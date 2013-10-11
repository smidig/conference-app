class AddRoomslotPriorityToTalks < ActiveRecord::Migration
  def change
    add_column :talks, :roomslot_priority, :integer
  end
end
