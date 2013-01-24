class CreateTalkCategories < ActiveRecord::Migration
  def change
    create_table :talk_categories do |t|
      t.string :name

      t.timestamps
    end
    add_column :talks, :talk_category_id, :integer
  end
end
