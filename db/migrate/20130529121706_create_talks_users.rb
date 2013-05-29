class CreateTalksUsers < ActiveRecord::Migration
  def up
    create_table :talks_users, :id => false do |t|
      t.integer :talk_id
      t.integer :user_id
    end
  end

  def down
    drop_table :talks_users
  end
end