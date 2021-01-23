class UpdateWorkoutFields < ActiveRecord::Migration[6.0]
  def change
    change_column :workouts, :name, :string, null: false
    change_column :workouts, :duration, :integer, default: 0, null: false
  end
end
