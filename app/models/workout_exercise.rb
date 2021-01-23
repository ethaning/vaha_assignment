# == Schema Information
#
# Table name: workout_exercises
#
#  id          :bigint           not null, primary key
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  exercise_id :bigint           not null
#  workout_id  :bigint           not null
#
# Indexes
#
#  index_workout_exercises_on_exercise_id  (exercise_id)
#  index_workout_exercises_on_workout_id   (workout_id)
#
# Foreign Keys
#
#  fk_rails_...  (exercise_id => exercises.id)
#  fk_rails_...  (workout_id => workouts.id)
#
class WorkoutExercise < ApplicationRecord
  belongs_to :workout
  belongs_to :exercise

  after_create :update_workout_duration
  after_destroy :update_workout_duration

  private

  def update_workout_duration
    workout.update(duration: workout.exercises.sum(:duration))
  end
end
