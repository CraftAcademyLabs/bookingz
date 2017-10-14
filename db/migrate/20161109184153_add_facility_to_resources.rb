class AddFacilityToResources < ActiveRecord::Migration[5.1]
  def change
    add_reference :resources, :facility, foreign_key: true
  end
end
