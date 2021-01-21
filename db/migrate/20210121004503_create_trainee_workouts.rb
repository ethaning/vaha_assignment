class CreateTraineeWorkouts < ActiveRecord::Migration[6.1]
  def change
    create_table :trainee_workouts do |t|
      t.references :trainee, null: false, foreign_key: { to_table: :users }
      t.references :workout, null: false, foreign_key: true

      t.timestamps
    end
  end
end
