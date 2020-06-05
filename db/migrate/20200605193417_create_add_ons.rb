class CreateAddOns < ActiveRecord::Migration[6.0]
  def change
    create_table :add_ons do |t|
      t.string :name
      t.decimal :daily_rate
      t.string :serial_number

      t.timestamps
    end
  end
end
