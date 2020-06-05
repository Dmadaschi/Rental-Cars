class CreateAddOnCarRentals < ActiveRecord::Migration[6.0]
  def change
    create_table :add_on_car_rentals do |t|
      t.references :add_on, null: false, foreign_key: true
      t.references :car_rental, null: false, foreign_key: true

      t.timestamps
    end
  end
end
