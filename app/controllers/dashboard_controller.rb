class DashboardController < ApplicationController
  before_action :authenticate_user!

  def index
    @resources = Resource.all
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

    rescue => e
      flash[:error] = e.message.humanize
    end
    redirect_to root_path(date: booking_params[:booking_date])
  end

  def edit_booking
    id = params[:booking][:resource_id]
    @resource = Resource.find(id)
    date = DateTime.parse([booking_params[:booking_date], booking_params[:original_time_start]].join(' '))
    booking = @resource.bookings.find_by(time_start: date)
    booking.time_start = DateTime.parse([booking_params[:booking_date], booking_params[:time_start]].join(' '))
    booking.time_end = DateTime.parse([booking_params[:booking_date], booking_params[:time_end]].join(' '))
    booking.client = booking_params[:client]
    booking.save

    redirect_to root_path(date: booking_params[:booking_date])
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
end
