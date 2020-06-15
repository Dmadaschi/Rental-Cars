class CarRental < ApplicationRecord
  belongs_to :rental
  belongs_to :car
  belongs_to :user
  has_many :add_on_car_rentals
  has_many :add_ons, through: :add_on_car_rentals

  validates :daily_rate, presence: true

  before_create :set_start_date

  def finish!
    self.end_date = Time.zone.now

    self.total = ((((end_date - start_date).to_i / 1.day) * daily_rate) +
                      car_insurance + third_part_insurance)
    save!
    rental.completed!
    car.available!
  end

  def start!
    self.daily_rate = rental.car_category.daily_rate + add_ons.map(&:daily_rate).sum
    rental.ongoing!
    car.rented!
    save!
  end

  private

  def set_start_date
    self.start_date = Time.zone.now
  end
end
