class AddTicketToUser < ActiveRecord::Migration
  def change
    add_column :users, :ticket_id, :integer
  end
end
