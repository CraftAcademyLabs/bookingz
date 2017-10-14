class Api::ApiController < ActionController::API
  before_action :set_default_response_format

  def ping
    render json: {message: 'Pong'}
  end

  def index
    @date = set_date
    @resources = Resource.all
    if in_weekly_mode?
      render :index_weekly
    else
      render :index
    end
  end

  def show
    @date = set_date
    @resource = Resource.find_by(uuid: params[:uuid])
  end

  def create
    facility = Facility.find_by(code: params[:resource][:f_code])
    @resource = Resource.new(resource_params.merge(facility: facility))
    @resource.schedule = IceCube::Schedule.new(Date.today - 1.year, duration: 1.year)
    @resource.schedule.add_recurrence_rule IceCube::Rule.daily
    if @resource.save
      render :create
    else
      render json: {message: @resource.errors.full_messages.sort}
    end
  end

  def update
    @resource = Resource.find_by(uuid: params[:uuid])
    if @resource.update_attributes(resource_params)
      render json: {id: @resource.id,
                    uuid: @resource.uuid,
                    designation: @resource.designation}
    else
      render json: {message: @resource.errors.full_messages.sort}
    end
  end

  def create_booking
    @resource = Resource.find_by(uuid: params[:uuid])
    @date = set_date
    start_seconds = Time.parse(params[:time_start]).seconds_since_midnight
    end_seconds = Time.parse(params[:time_end]).seconds_since_midnight

    start = Date.parse(params[:time_start]) + start_seconds.seconds
    to = Date.parse(params[:time_end]) + end_seconds.seconds

    if start.min < 30
      start_time = start.beginning_of_hour + 1.second
      end_time = start.end_of_hour - 30.minutes
    else
      start_time = start.beginning_of_hour + 30.minutes + 1.second
      end_time = start.end_of_hour
    end
    if !@resource.check_availability(time_start: start, time_end: to, amount: 0)
      render json: {message: 'This room is already booked'}, status: 422
    else
      user = User.superadmins.first
      @resource.be_booked! user,
                           time_start: start_time,
                           time_end: end_time,
                           amount: @resource.capacity,
                           client: params[:client]
      render :show
    end
  end


  private

  def set_date
    params[:date] || Date.today.to_s
  end

  def resource_params
    params.require(:resource).permit(:uuid,
                                     :designation,
                                     :description,
                                     :capacity,
                                     :facility_id,
                                     :direction)
  end

  def in_weekly_mode?
    Settings.mode == :weekly_view
  end

  def set_default_response_format
    request.format = :json
  end

end
