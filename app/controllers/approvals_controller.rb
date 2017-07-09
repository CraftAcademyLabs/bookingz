class ApprovalsController < ApplicationController
  before_action :authenticate_user!
  before_action :authenticate_superuser

  def index
    @facilities = Facility.all
    if params[:approved] == 'false'
      @users = User.where(approved: false, superadmin: false)
    else
      @users = User.where(superadmin: false)
    end
  end

  def approve_user
    @user = User.find(params[:id])
    if @user.facility
      @user.update_attribute(:approved, true)
    else
      flash[:alert] = 'User needs to be assigned to a Facility before approval'
    end
    redirect_back(fallback_location: approvals_users_path)
  end

end
