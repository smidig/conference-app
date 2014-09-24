class AddSizeToRooms < ActiveRecord::Migration
  def change
    add_column :rooms, :size, :integer, :default => 0
  end
end
