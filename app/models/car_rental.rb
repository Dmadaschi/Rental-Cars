class CarRental < ApplicationRecord
  belongs_to :rental
  belongs_to :car
  belongs_to :user

  validates :daily_rate, :car_insurance,
            :third_part_insurance, presence:true

  before_create :set_start_date

  private

  def set_start_date
    self.start_date = Date.today
  end
end
