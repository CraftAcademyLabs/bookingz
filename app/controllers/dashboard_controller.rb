class DashboardController < ApplicationController
  before_action :authenticate_user!
  def index
    @resources = Resource.all
  end

  def create_booking
    id = params[:booking][:resource_id]
    @resource = Resource.find(id)
    binding.pry
  end
end
