# == Schema Information
#
# Table name: trainee_workouts
#
#  id         :bigint           not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  trainee_id :bigint           not null
#  workout_id :bigint           not null
#
# Indexes
#
#  index_trainee_workouts_on_trainee_id  (trainee_id)
#  index_trainee_workouts_on_workout_id  (workout_id)
#
# Foreign Keys
#
#  fk_rails_...  (trainee_id => users.id)
#  fk_rails_...  (workout_id => workouts.id)
#
class TraineeWorkout < ApplicationRecord
  belongs_to :trainee, class_name: "User"
  belongs_to :workout

  def to_builder
    Jbuilder.new do |tw|
      tw.(self, *self.attributes.except("creator_id", "workout_id").keys)
      tw.trainee trainee.to_builder
      tw.workout workout.to_builder
    end
  end
end
