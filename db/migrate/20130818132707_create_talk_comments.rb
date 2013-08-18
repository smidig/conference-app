class CreateTalkComments < ActiveRecord::Migration
  def change
    create_table :talk_comments do |t|
      t.text :content
      t.belongs_to :user
      t.belongs_to :talk
      t.timestamps
    end
  end
end
