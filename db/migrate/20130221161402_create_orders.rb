class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.string :comment
      t.boolean :completed

      t.timestamps
    end
  end
end
