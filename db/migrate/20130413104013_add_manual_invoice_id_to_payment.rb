class AddManualInvoiceIdToPayment < ActiveRecord::Migration
  def change
    add_column :payments, :manual_invoice_id, :string
  end
end
