class CreateCarModels < ActiveRecord::Migration[6.0]
  def change
    create_table :car_models do |t|
      t.string :name
      t.string :year
      t.references :manufacturer, null: false, foreign_key: true
      t.string :motorization
      t.references :car_category, null: false, foreign_key: true
      t.string :fuel_type

      t.timestamps
    end
  end
end
