class AddWorkshopFlagToTimeslots < ActiveRecord::Migration
  def change
    add_column :timeslots, :is_workshop_slot, :boolean
  end
end
