class AddAbbreviationToCategory < ActiveRecord::Migration
  def self.up
    add_column :talk_categories, :abbreviation, :string

    TalkCategory.reset_column_information

    TalkCategory.all.each do |tc|
      tc.abbreviation = tc.name
      tc.save!
    end

    change_column :talk_categories, :abbreviation, :string, :null => false
    add_index :talk_categories, :abbreviation, :unique => true
  end

  def self.down
    remove_column :talk_categories, :abbreviation
  end
end

