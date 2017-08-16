class Facility < ApplicationRecord
  geocoded_by :full_address
  has_attached_file :attachment,
                    storage: :s3,
                    s3_credentials: {
                        bucket: ENV['AWS_BUCKET'],
                        access_key_id: ENV['AWS_ACCESS_KEY'],
                        secret_access_key: ENV['AWS_SECRET_KEY'],
                        s3_region: ENV['AWS_REGION'],
                        url: :s3_domain_url,
                        s3_host_name: "s3-#{ENV['AWS_REGION']}.amazonaws.com"
                    },
                    styles: { medium: '300x300>',
                              thumb: '100x100>' }

  validates_attachment :attachment,
                       content_type:
                           {content_type: %w(image/jpg image/jpeg image/png image/gif)}
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
