class Facility < ApplicationRecord
  geocoded_by :full_address
  after_validation :geocode, if: ->(obj) do
    obj.address.present? and obj.address_changed? || obj.post_code_changed? || obj.city_changed?
  end

  validates_presence_of :name, :code
  validates_length_of :code, is: 4
  before_validation :generate_random_code

  has_many :users
  has_many :resources


  def full_address
    Geocoder.address([self.address, self.post_code, self.city].join(', '))
  end

  private

  def generate_random_code
    if self.code.nil?
      self.code = [*('a'..'z'), *('0'..'9')].sample(4).join
    end
  end

end
