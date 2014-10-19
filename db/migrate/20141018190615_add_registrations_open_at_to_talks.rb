class AddRegistrationsOpenAtToTalks < ActiveRecord::Migration
  def change
    add_column :talks, :registrations_open_at, :datetime
  end
end
