class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :set_locale

  private
  def set_locale
    I18n.locale = params[:locale] || locale_from_header
    Rails.application.routes.default_url_options[:locale]= I18n.locale
  end

  # Temporal authorization method
  def authenticate_superuser
    redirect_to root_path, alert: 'You are not authorized to view this page' unless current_user.superadmin?
  end


  def locale_from_header
    case request.env['HTTP_ACCEPT_LANGUAGE'].scan(/^[a-z]{2}/).first
    when 'sv'
      'sv'
    when 'en'
      'en'
    else
      I18n.default_locale
    end
  end
end
