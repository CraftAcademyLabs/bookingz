class ApprovalsController < ApplicationController
  before_action :authenticate_user!

  def index
    if params[:approved] == 'false'
      @users = User.where(approved: false)
    else
      @users = User.all
    end
  end

  def approve_user
    @user = User.find(params[:id])
    unless @user.approved
      @user.update_attribute(:approved, true)
    end
    redirect_back(fallback_location: approvals_users_path)
  end

end
