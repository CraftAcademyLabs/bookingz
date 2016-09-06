require 'rails_helper'

describe ActsAsBookable::Booking, type: :model do
  it{is_expected.to respond_to :client}
  it{is_expected.to respond_to :time_start}
  it{is_expected.to respond_to :time_end}
  it{is_expected.to respond_to :amount}

end