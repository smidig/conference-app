class AddManualCityToPayments < ActiveRecord::Migration
  def change
    add_column :payments, :manual_city, :string
  end
end
