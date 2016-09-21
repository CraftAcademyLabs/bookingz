class ApprovalsController < ApplicationController
  # before_action :authenticate_user!

  def index
    if params[:approved] == "false"
      @users = User.where(approved: false)
    else
      @users = User.all
    end
  end

  def approve_user
    if params[:approved] == "false"
      @user = User.where(approved: false)
      if @user.approved == false
        @user.approved = true
      end
    end
    @user.save
  end
end
