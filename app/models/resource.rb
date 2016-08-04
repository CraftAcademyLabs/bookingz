class Resource < ApplicationRecord
  acts_as_bookable time_type: :range,
                   capacity_type: :open
end
