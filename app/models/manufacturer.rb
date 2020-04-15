class Manufacturer < ApplicationRecord
  has_many :car_models
  validates :name, presence: true
  validates :name, uniqueness: true
end
