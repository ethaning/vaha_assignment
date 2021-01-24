# == Schema Information
#
# Table name: workout_sessions
#
#  id                 :bigint           not null, primary key
#  completed_at       :datetime
#  started_at         :datetime
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  trainee_workout_id :bigint           not null
#
# Indexes
#
#  index_workout_sessions_on_trainee_workout_id  (trainee_workout_id)
#
# Foreign Keys
#
#  fk_rails_...  (trainee_workout_id => trainee_workouts.id)
#
class WorkoutSession < ApplicationRecord
  belongs_to :trainee_workout
  has_one :trainee, through: :trainee_workout
  has_one :workout, through: :trainee_workout

  scope :filtered_at_date, ->(from_date, to_date) do
    where(created_at: from_date.to_date.beginning_of_day..to_date.to_date.end_of_day)
  end

  def to_builder
    Jbuilder.new do |tw|
      tw.(self, *self.attributes.except("trainee_workout_id").keys)
      tw.workout workout.to_builder
    end
  end
end
