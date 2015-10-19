class AddNewConfigForOpeningProgram < ActiveRecord::Migration
  def up
    Setting.create(key: 'program-available', val: false, setting_type: 'boolean')
  end

  def down
  end
end
