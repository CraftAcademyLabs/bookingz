class AddAddressFieldsToFacility < ActiveRecord::Migration[5.1]
  def change
    add_column :facilities, :post_code, :string
    add_column :facilities, :city, :string
    add_column :facilities, :country, :string
  end
end
