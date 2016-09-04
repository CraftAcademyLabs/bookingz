class AddCapacityAndScheduleToResource < ActiveRecord::Migration[5.0]
  def change
    add_column :api, :capacity, :integer
    add_column :api, :schedule, :text
  end
end
