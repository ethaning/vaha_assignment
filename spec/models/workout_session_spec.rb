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
require 'rails_helper'

RSpec.describe WorkoutSession, type: :model do
  context "relations" do
    it { should belong_to(:trainee_workout) }
    it { should have_one(:trainee).through(:trainee_workout) }
  end
end
