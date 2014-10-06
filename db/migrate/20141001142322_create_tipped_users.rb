class CreateTippedUsers < ActiveRecord::Migration
  def change
    create_table :tipped_users do |t|
      t.string :email

      t.timestamps
    end
  end
end
