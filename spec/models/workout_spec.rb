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
require 'rails_helper'

RSpec.describe Workout, type: :model do
  subject { build :workout }

  context "relations" do
    it { should belong_to(:creator).class_name("User") }
    it { should have_many(:trainees).through(:trainee_workouts) }
    it { should have_many(:exercises).through(:workout_exercises) }
  end

  context "validations" do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:state) }
    it { should validate_presence_of(:duration) }
    it { should validate_numericality_of(:duration).only_integer.is_greater_than_or_equal_to(0) }

    it { should define_enum_for(:state).with_values(%i[draft published]) }

    # validate that creator is a trainer
  end

  # check that duration is updated when exercises are added/removed
end
