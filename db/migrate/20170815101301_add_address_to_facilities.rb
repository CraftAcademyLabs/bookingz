class AddAddressToFacilities < ActiveRecord::Migration[5.1]
  def change
    add_column :facilities, :address, :string
  end
end
