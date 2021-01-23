# == Schema Information
#
# Table name: workouts
#
#  id         :bigint           not null, primary key
#  duration   :integer          default(0), not null
#  name       :string           not null
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

  validates :name, :state, presence: true
  validates :duration, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validate :creator_is_trainer

  enum state: { draft: 0, published: 1 }

  private

  def creator_is_trainer
    errors.add :creator, "must be a Trainer" if creator && !creator.trainer?
  end
end
