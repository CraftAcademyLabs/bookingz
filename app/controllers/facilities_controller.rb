class FacilitiesController < ApplicationController
  before_action :authenticate_superuser
  def new
    @facility = Facility.new
  end

  def create
  end

  private
  def authenticate_superuser
    redirect_to root_path, alert: 'You are not authorized to view this page' unless current_user.superadmin
  end
end
