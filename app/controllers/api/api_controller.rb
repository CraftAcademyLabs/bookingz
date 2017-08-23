class Api::ApiController < ActionController::API

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

    start_seconds += 1.second
    binding.pry

    start = Date.parse(params[:time_start]) + start_seconds.seconds
    to = Date.parse(params[:time_end]) + end_seconds.seconds
    user = User.is_superadmin.first
    @resource.be_booked! user,
                         time_start: start,
                         time_end: to,
                         amount: @resource.capacity,
                         client: params[:client]
    render :show
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

end
