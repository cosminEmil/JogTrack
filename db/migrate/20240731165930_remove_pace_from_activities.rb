class RemovePaceFromActivities < ActiveRecord::Migration[7.1]
  def change
    remove_column :activities, :pace, :decimal, precision: 10, scale: 2
  end
end
