class FacilitiesController < ApplicationController
  before_action :authenticate_superuser

  def index
    @facilities = Facility.all
  end

  def new
    @facility = Facility.new
  end

  def create
    @facility = Facility.new(facility_params)
    if @facility.save
      flash[:notice] = "Facility #{@facility.name} was saved"
      redirect_to facilities_path
    else
      render :new
    end
  end

  private
  # Temporal authorization method
  def authenticate_superuser
    redirect_to root_path, alert: 'You are not authorized to view this page' unless current_user.superadmin
  end

  def facility_params
    params.require(:facility).permit(:name)
  end
end
