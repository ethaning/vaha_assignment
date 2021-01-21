class CreateWorkouts < ActiveRecord::Migration[6.1]
  def change
    create_table :workouts do |t|
      t.string :name
      t.references :creator, null: false, foreign_key: { to_table: :users }
      t.integer :duration
      t.integer :state, default: 0

      t.timestamps
    end
  end
end
