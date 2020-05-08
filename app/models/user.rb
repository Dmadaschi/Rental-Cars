class User < ApplicationRecord
  has_many :car_rentals
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
