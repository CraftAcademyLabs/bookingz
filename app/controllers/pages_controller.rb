class PagesController < ApplicationController
  include HighVoltage::StaticPage
  before_action :authenticate_user!

  def show
    render page_to_render
  end

  private

  def page_to_render
    case params[:id]
    when 'instructions'
      'instructions'
    when 'ca_labs'
      'ca_labs'
    else
      raise 'You have not defined the page yet'
    end
  end
end
