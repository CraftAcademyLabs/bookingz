class AddUuidToResource < ActiveRecord::Migration[5.0]
  def change
    add_column :resources, :uuid, :string
  end
end
