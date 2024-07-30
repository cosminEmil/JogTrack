class ChangeDistanceToFloatInActivities < ActiveRecord::Migration[7.1]
  def change
    change_column :activities, :distance, :float
  end
end
