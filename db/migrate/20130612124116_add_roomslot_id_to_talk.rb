class AddRoomslotIdToTalk < ActiveRecord::Migration
  def change
    add_column :talks, :roomslot_id, :integer
  end
end
