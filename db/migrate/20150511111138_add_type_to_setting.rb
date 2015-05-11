class AddTypeToSetting < ActiveRecord::Migration
  def change
    add_column :settings, :setting_type, :string
  end
end
