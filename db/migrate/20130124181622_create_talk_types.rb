class CreateTalkTypes < ActiveRecord::Migration
  def change
    create_table :talk_types do |t|
      t.string :name
      t.integer :duration
      t.boolean :visible

      t.timestamps
    end
    add_column :talks, :talk_type_id, :integer
  end
end
