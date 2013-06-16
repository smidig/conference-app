class CreateTimeslots < ActiveRecord::Migration
  def change
    create_table :timeslots do |t|
      t.datetime :start
      t.datetime :end

      t.timestamps
    end
  end
end
