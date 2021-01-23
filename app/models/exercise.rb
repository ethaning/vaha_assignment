# == Schema Information
#
# Table name: exercises
#
#  id         :bigint           not null, primary key
#  duration   :integer          default(0), not null
#  name       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_exercises_on_name  (name) UNIQUE
#
class Exercise < ApplicationRecord
  has_many :workout_exercises
  has_many :workouts, through: :workout_exercises

  validates :name, presence: true, uniqueness: true
  validates :duration, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  def to_builder
    Jbuilder.new do |exercise|
      exercise.(self, *self.attributes.keys)
    end
  end
end
