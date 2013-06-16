class CreateRoomslots < ActiveRecord::Migration
  def change
    create_table :roomslots do |t|
      t.integer :timeslot_id
      t.integer :room_id

      t.timestamps
    end
  end
end
