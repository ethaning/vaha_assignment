# == Schema Information
#
# Table name: workouts
#
#  id         :bigint           not null, primary key
#  duration   :integer
#  name       :string
#  state      :integer          default(0)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  creator_id :bigint           not null
#
# Indexes
#
#  index_workouts_on_creator_id  (creator_id)
#
# Foreign Keys
#
#  fk_rails_...  (creator_id => users.id)
#
class Workout < ApplicationRecord
  belongs_to :creator, class_name: "User"

  has_many :trainee_workouts
  has_many :trainees, through: :trainee_workouts

  has_many :workout_exercises
  has_many :exercises, through: :workout_exercises

  enum status: { draft: 0, published: 1 }
end
