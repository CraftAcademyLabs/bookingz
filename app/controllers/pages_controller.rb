class PagesController < ApplicationController
  include HighVoltage::StaticPage
  before_action :authenticate_user!
end
