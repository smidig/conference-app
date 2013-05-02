class AddStatusToTalk < ActiveRecord::Migration
  def change
  	add_column :talks, :status, :string, :default => "pending"
  end
end
