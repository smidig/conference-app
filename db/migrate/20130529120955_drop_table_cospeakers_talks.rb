class DropTableCospeakersTalks < ActiveRecord::Migration
  def change
  	drop_table :cospeakers_talks
  end
end
