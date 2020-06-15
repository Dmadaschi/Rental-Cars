class AddEndDateToCarRental < ActiveRecord::Migration[6.0]
  def change
    add_column :car_rentals, :end_date, :datetime
  end
end
