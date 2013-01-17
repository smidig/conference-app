class AddFieldsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :admin, :boolean
    add_column :users, :name, :string
    add_column :users, :tlf, :string
    add_column :users, :company, :string
    add_column :users, :accepcted_privacy, :boolean
    add_column :users, :accepted_optional_email, :boolean
    add_column :users, :twitter, :string
    add_column :users, :allergies, :string
  end
end
