class AddDirectionToResources < ActiveRecord::Migration[5.1]
  def change
    add_column :resources, :direction, :string
  end
end
