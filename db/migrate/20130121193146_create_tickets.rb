class CreateTickets < ActiveRecord::Migration
  def change
    create_table :tickets do |t|
      t.string :name
      t.integer :price
      t.boolean :active
      t.boolean :visible

      t.timestamps
    end
  end
end
