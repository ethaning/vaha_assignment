# == Schema Information
#
# Table name: exercises
#
#  id         :bigint           not null, primary key
#  duration   :integer
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Exercise < ApplicationRecord
  has_many :workout_exercises
  has_many :workouts, through: :workout_exercises
end
