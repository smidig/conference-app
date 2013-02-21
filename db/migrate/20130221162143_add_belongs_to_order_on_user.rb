class AddBelongsToOrderOnUser < ActiveRecord::Migration
  def change
     add_column :users, :order_id, :integer
  end
end
