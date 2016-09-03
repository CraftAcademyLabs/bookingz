class PagesController < ApplicationController
  include HighVoltage::StaticPage
  before_action :authenticate_user!

  #:page_to_render

  private

  # def page_to_render
  #   case params[:id]
  #   when 'ca_labs'
  #     'ca_labs'
  #   when 'instructions'
  #     'instructions'
  #   end
  # end
end
