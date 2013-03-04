class AddInvoiceIdToPayment < ActiveRecord::Migration
  def change
    add_column :payments, :invoice_id, :string
  end
end
