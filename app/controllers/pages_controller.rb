class PagesController < ApplicationController
  include HighVoltage::StaticPage
  before_action :authenticate_user!

  def show
    render 'pages/instructions'
  end
end
