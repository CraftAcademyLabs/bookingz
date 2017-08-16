class AddLatitudeAndLongitudeToFacility < ActiveRecord::Migration[5.1]
  def change
    add_column :facilities, :latitude, :float
    add_column :facilities, :longitude, :float
  end
end
