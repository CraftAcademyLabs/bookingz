class AddCapacityAndScheduleToResource < ActiveRecord::Migration[5.1]
  def change
    add_column :resources, :capacity, :integer
    add_column :resources, :schedule, :text
  end
end
