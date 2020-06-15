class Rental < ApplicationRecord
  belongs_to :customer
  belongs_to :car_category
  has_one :car_rental
  validates :start_date, :end_date, presence: true
  enum status: { scheduled: 0, ongoing: 5, completed: 10 }

  before_create :generate_code

  private

  def generate_code
    self.code = SecureRandom.alphanumeric(6).upcase
  end
end
