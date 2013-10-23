class AddPriorityToRooms < ActiveRecord::Migration
  def change
    add_column :rooms, :priority, :string
  end
end
