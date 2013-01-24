class CreateTalks < ActiveRecord::Migration
  def change
    create_table :talks do |t|
      t.timestamps
    end
  end
end
