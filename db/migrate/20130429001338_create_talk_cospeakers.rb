class CreateTalkCospeakers < ActiveRecord::Migration
  def self.up
    create_table :cospeakers_talks, :id => false do |t|
        t.references :talk
        t.references :user
    end
    add_index :cospeakers_talks, [:talk_id, :user_id]
    add_index :cospeakers_talks, [:user_id, :talk_id]
  end

  def self.down
    drop_table :cospeakers_talks
  end
end
