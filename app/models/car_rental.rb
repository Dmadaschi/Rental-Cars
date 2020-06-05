class CarRental < ApplicationRecord
  belongs_to :rental
  belongs_to :car
  belongs_to :user
  has_many :add_on_car_rentals
  has_many :add_ons, through: :add_on_car_rentals

  validates :daily_rate, presence: true

  before_create :set_start_date

  private

  def set_start_date
    self.start_date = Date.today
  end
end
