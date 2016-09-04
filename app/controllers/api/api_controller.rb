class Api::ApiController < ActionController::Base
  protect_from_forgery with: :null_session
  respond_to :json


  def ping
    render json: {message: 'Pong'}
  end

  def index
    @date = params[:date] || Date.today.to_s
    @resources = Resource.all
    render :index
  end
end