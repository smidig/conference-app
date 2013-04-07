class AddIncludesDinnerColumnToUsers < ActiveRecord::Migration
  def change
    add_column :users, :includes_dinner, :boolean
  end
end
