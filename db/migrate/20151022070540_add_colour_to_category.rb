class AddColourToCategory < ActiveRecord::Migration
  def change
    add_column :talk_categories, :colour, :string, :null => false, :default => '#999999'
  end
end
