class Car < ApplicationRecord
  belongs_to :car_model
  has_many :car_rentals
  enum status: { available: 0, rented: 5 }

  def description
    "#{car_model.manufacturer.name} #{car_model.name} - Placa: #{license_plate} - Cor: #{color}"
  end
end
