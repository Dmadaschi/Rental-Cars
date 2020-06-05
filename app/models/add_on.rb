class AddOn < ApplicationRecord
  has_many :add_on_car_rentals
  has_many :car_rentals, through: :add_on_car_rentals
end
