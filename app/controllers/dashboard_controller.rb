class DashboardController < ApplicationController
  before_action :authenticate_user!
  def index
    @resources = Resource.all
  end
end
