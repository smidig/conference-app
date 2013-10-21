class WorkshopParticipants < ActiveRecord::Migration
  def up
    create_table :workshop_participants do |t|
        t.references :user
        t.references :talk
        t.timestamps
    end
  end

  def down
    drop_table :workshop_participants
  end
end
