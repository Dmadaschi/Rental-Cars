class AddDriverInformationsToCustomer < ActiveRecord::Migration[6.0]
  def change
    add_column :customers, :driver_license, :string
    add_column :customers, :birth_date, :date
    add_column :customers, :phone, :string
  end
end
