class AddFieldsToRoomslots < ActiveRecord::Migration
  def change
    add_column :roomslots, :title, :string
    add_column :roomslots, :description, :text
  end
end
