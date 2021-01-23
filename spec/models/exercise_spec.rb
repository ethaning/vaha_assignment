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
require 'rails_helper'

RSpec.describe Exercise, type: :model do
  subject { build :exercise }

  context "relations" do
    it { should have_many(:workouts).through(:workout_exercises) }
  end

  context "validations" do
    it { should validate_presence_of(:name) }
    it { should validate_uniqueness_of(:name) }
    it { should validate_presence_of(:duration) }
    it { should validate_numericality_of(:duration).only_integer.is_greater_than_or_equal_to(0) }
  end
end
