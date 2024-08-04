class AddLocationToActivity < ActiveRecord::Migration[7.1]
  def change
    add_column :activities, :location, :string
  end
end
