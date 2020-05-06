class CreateCars < ActiveRecord::Migration[6.0]
  def change
    create_table :cars do |t|
      t.references :car_model, null: false, foreign_key: true
      t.string :license_plate
      t.integer :mileage
      t.string :color
      t.timestamps
    end
  end
end
