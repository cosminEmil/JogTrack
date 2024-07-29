class CreateActivities < ActiveRecord::Migration[7.1]
  def change
    create_table :activities do |t|
      t.integer :distance
      t.integer :hours
      t.integer :minutes
      t.integer :seconds
      t.text :title
      t.text :description
      t.datetime :run_at
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
    add_index :activities, [:user_id, :created_at]
  end
end
