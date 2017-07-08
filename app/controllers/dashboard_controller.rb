class DashboardController < ApplicationController
  before_action :authenticate_user!

  def index
    if current_user.superadmin?
      @resources = Resource.all
    else
      @resources = current_user.try(:facility).try(:resources) || Resource.all
    end
  end

  def create_booking
    id = params[:booking][:resource_id]
    @resource = Resource.find(id)
    @resource.schedule.add_recurrence_rule IceCube::Rule.daily

    start_seconds = Time.parse([booking_params[:booking_date],
                                booking_params[:time_start]].join(' ')).seconds_since_midnight

    end_seconds = Time.parse([booking_params[:booking_date],
                              booking_params[:time_end]].join(' ')).seconds_since_midnight
    start_seconds += 1.second

    start = Date.parse(booking_params[:booking_date]) + start_seconds.seconds
    to = Date.parse(booking_params[:booking_date]) + end_seconds.seconds

    begin
      @resource.be_booked! current_user,
                           time_start: start,
                           time_end: to,
                           amount: @resource.capacity,
                           client: booking_params[:client]
      flash[:notice] = t('dashboard.create_success')

    rescue => e
      flash[:error] = t('dashboard.') + e.message.humanize
    end
    redirect_to root_path(date: booking_params[:booking_date])
  end

  def edit_booking
    id = booking_params[:resource_id]
    @resource = Resource.find(id)
    date = get_date(booking_params)
    booking = @resource.bookings.find_by(time_start: date + 1.second) || @resource.bookings.find_by(time_start: date)
    booking.time_start = DateTime.parse([booking_params[:booking_date], booking_params[:time_start]].join(' '))
    booking.time_end = DateTime.parse([booking_params[:booking_date], booking_params[:time_end]].join(' '))
    booking.client = booking_params[:client]
    booking.save

    redirect_to root_path(date: booking_params[:booking_date])
  end

  def delete_booking
    id = delete_booking_params[:resource_id]
    @resource = Resource.find(id)
    date = get_date(delete_booking_params)
    booking = @resource.bookings.find_by(time_start: date + 1.second) || @resource.bookings.find_by(time_start: date)
    booking.destroy
    flash[:notice] = t('dashboard.delete_success')
    redirect_to root_path(date: delete_booking_params[:booking_date])
  end

  def send_note
    content = {note: params[:note], time: Time.now.strftime("%I:%H, %m/%d/%Y"), data: { facility_code: current_user.facility.code } }
    BroadcastNoteJob.perform_now(content)
  end

  private
  def booking_params
    params.require(:booking).permit(:resource_id,
                                    :booking_date,
                                    :client,
                                    :time_start,
                                    :time_end,
                                    :expiration_date,
                                    :original_time_start)
  end

  def delete_booking_params
    params.require(:booking).permit(:resource_id,
                                    :booking_date,
                                    :original_time_start)
  end

  def get_date(params)
    DateTime.parse([params[:booking_date], params[:original_time_start]].join(' '))
  end
end
