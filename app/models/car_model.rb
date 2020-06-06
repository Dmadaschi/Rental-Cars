class CarModel < ApplicationRecord
  belongs_to :manufacturer
  belongs_to :car_category

  validates :name, :year, :motorization, :fuel_type, presence: true

  def description
    "#{manufacturer.name} #{name} - #{year} - #{motorization} - #{fuel_type}"
  end
end
