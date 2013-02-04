class AddTicketToUser < ActiveRecord::Migration
  def change
    add_column :users, :ticked_id, :integer
  end
end
