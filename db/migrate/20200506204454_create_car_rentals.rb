class CreateCarRentals < ActiveRecord::Migration[6.0]
  def change
    create_table :car_rentals do |t|
      t.references :rental, null: false, foreign_key: true
      t.references :car, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.datetime :start_date
      t.decimal :daily_rate
      t.decimal :car_insurance
      t.decimal :third_part_insurance

      t.timestamps
    end
  end
end
