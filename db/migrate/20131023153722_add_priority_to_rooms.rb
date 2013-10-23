class AddPriorityToRooms < ActiveRecord::Migration
  def change
    add_column :rooms, :priority, :integer, :default => 0
  end
end
