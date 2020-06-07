class Car < ApplicationRecord
  belongs_to :car_model
  has_many :car_rentals

  validates :license_plate, :mileage, :color, presence: true
  validates :mileage, numericality: true
  validates :license_plate, uniqueness: true
  before_create :define_availability

  enum status: { available: 0, rented: 5 }

  def description
    "#{car_model.manufacturer.name} #{car_model.name} - Placa: #{license_plate} - Cor: #{color}"
  end

  private

  def define_availability
    self.status = 'available'
  end
end
