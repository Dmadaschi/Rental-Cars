class AddTotalToCarRental < ActiveRecord::Migration[6.0]
  def change
    add_column :car_rentals, :total, :float
  end
end
