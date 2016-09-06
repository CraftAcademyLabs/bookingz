class CreateResources < ActiveRecord::Migration[5.0]
  def change
    create_table :api do |t|
      t.string :designation
      t.text :description

      t.timestamps
    end
  end
end
