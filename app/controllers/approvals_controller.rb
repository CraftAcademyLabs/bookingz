class ApprovalsController < ApplicationController
  before_action :authenticate_user!
  before_action :authenticate_superuser

  def index
    if params[:approved] == 'false'
      @users = User.where(approved: false, superadmin: false)
    else
      @users = User.where(superadmin: false)
    end
  end

  def approve_user
    @user = User.find(params[:id])
    unless @user.approved && @user.facility
      @user.update_attribute(:approved, true)
    end
    flash[:alert] = 'User needs to be assigned to a Facility before approval'
    redirect_back(fallback_location: approvals_users_path)
  end

end
