class AddOrganizationNumberToPayments < ActiveRecord::Migration
  def change
    add_column :payments, :manual_organization_number, :integer
  end
end
