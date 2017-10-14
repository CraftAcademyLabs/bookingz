class AddUuidToResource < ActiveRecord::Migration[5.1]
  def change
    add_column :resources, :uuid, :string
  end
end
