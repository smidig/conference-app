class AddColorToRooms < ActiveRecord::Migration
  def change
    add_column :rooms, :color, :string
  end
end
