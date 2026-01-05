class AddStatusToBusSchedules < ActiveRecord::Migration[8.1]
  def change
    add_column :bus_schedules, :status, :integer , default: 0, null: false
  end
end
