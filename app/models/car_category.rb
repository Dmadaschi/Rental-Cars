class CarCategory < ApplicationRecord
  validates :name, :daily_rate, :car_insurance, :third_part_insurance, presence: true
  validates :name, uniqueness: true
  validates_numericality_of :daily_rate, :car_insurance, :third_part_insurance, greater_than: 0
end
