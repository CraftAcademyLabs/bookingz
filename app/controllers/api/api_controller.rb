class Api::ApiController < ActionController::API

  def ping
    render json: {message: 'Pong'}
  end

  def index
    @date = set_date
    @resources = Resource.all
  end

  def show
    @date = set_date
    @resource = Resource.find_by(uuid: params[:uuid])
  end


  private

  def set_date
    params[:date] || Date.today.to_s
  end
end
