class AddCodeToFacilities < ActiveRecord::Migration[5.1]
  def change
    add_column :facilities, :code, :string
  end
end
