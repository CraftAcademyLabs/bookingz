class Facility < ApplicationRecord
  geocoded_by :full_address   # can also be an IP address
  after_validation :geocode          # auto-fetch coordinates

  validates_presence_of :name, :code
  validates_length_of :code, is: 4
  before_validation :generate_random_code

  has_many :users
  has_many :resources


  def full_address
    [self.address, self.post_code, self.city].join(', ')
  end
  
  private

  def generate_random_code
    if self.code.nil?
      self.code = [*('a'..'z'),*('0'..'9')].sample(4).join
    end
  end

end
