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
FactoryBot.define do
  factory :workout_session do
    trainee_workout { nil }
    started_at { "2021-01-24 00:10:07" }
    completed_at { "2021-01-24 00:10:07" }
  end
end
