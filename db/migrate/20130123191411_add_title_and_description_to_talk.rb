class AddTitleAndDescriptionToTalk < ActiveRecord::Migration
  def change
  	add_column :talks, :title, :string
  	add_column :talks, :description, :text
  end
end
