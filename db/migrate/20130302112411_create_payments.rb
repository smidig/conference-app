class CreatePayments < ActiveRecord::Migration
  def change
    create_table :payments do |t|
      t.integer :price
      t.integer :paid_amount
      t.boolean :completed
      t.timestamp :completed_at
      t.text :paypal_params
      t.string :paypal_tx_id
      t.string :paypal_tx_type
      t.string :paypal_currency
      t.string :paypal_status
      t.string :paypal_payer_email
      t.string :manual_company_name
      t.string :manual_company_email
      t.string :manual_contact_person
      t.string :manual_street_address
      t.string :manual_post_code
      t.boolean :manual_invoice_sent
      t.integer :order_id
      t.string :type

      t.timestamps
    end
  end
end
