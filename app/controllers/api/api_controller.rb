class Api::ApiController < ActionController::Base
  protect_from_forgery with: :null_session
  respond_to :json

  def ping
    render json: {message: 'Pong'}
  end

  def index
    @date = set_date
    @resources = Resource.all
    render :index
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
