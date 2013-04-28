class RemoveAcceptPrivacyColumn < ActiveRecord::Migration
  def change
    remove_column :users, :accepcted_privacy
  end
end
