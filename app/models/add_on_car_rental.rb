class AddOnCarRental < ApplicationRecord
  belongs_to :add_on
  belongs_to :car_rental
end
