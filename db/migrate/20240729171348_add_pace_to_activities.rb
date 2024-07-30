class AddPaceToActivities < ActiveRecord::Migration[7.1]
  def change
    add_column :activities, :pace, :decimal, precision: 10, scale: 2
  end
end
