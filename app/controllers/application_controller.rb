class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :set_locale

  private
  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
    Rails.application.routes.default_url_options[:locale]= I18n.locale
  end

  # Temporal authorization method
  def authenticate_superuser
    redirect_to root_path, alert: 'You are not authorized to view this page' unless current_user.superadmin
  end

end
