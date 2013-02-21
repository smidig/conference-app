class AddPresentationToTalk < ActiveRecord::Migration
  def self.up
    add_attachment :talks, :presentation
  end

  def self.down
    remove_attachment :talks, :presentation
  end
end
