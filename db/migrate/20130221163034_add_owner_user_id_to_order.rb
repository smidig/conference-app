class AddOwnerUserIdToOrder < ActiveRecord::Migration
  def change
     add_column :orders, :owner_user_id, :integer
  end
end
