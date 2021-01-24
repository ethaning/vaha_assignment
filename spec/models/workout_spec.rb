# == Schema Information
#
# Table name: workouts
#
#  id         :bigint           not null, primary key
#  duration   :integer          default(0), not null
#  name       :string           not null
#  state      :integer          default("draft")
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
  let(:trainer) { create :trainer }
  let(:trainee) { create :trainee }

  subject { build :workout }

  context "relations" do
    it { should belong_to(:creator).class_name("User") }
    it { should have_many(:trainees).through(:trainee_workouts) }
    it { should have_many(:workout_sessions).through(:trainee_workouts) }
    it { should have_many(:exercises).through(:workout_exercises) }
  end

  context "validations" do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:state) }
    it { should validate_presence_of(:duration) }
    it { should validate_numericality_of(:duration).only_integer.is_greater_than_or_equal_to(0) }

    it { should define_enum_for(:state).with_values(%i[draft published]) }

    it "ensures that creator is a trainer" do
      subject.creator = trainer
      subject.save!

      expect(subject.errors.count).to eq(0)

      expect { subject.update!(creator: trainee) }.to raise_error(ActiveRecord::RecordInvalid)
    end
  end

  context "#duration" do
    let(:exercise) { create :exercise, duration: 60 }

    subject { create :workout }

    it "updates on save when exercises are added or removed" do
      expect(subject.exercises.count).to eq(0)
      expect(subject.duration).to eq(0)

      subject.exercises << exercise
      subject.reload

      expect(subject.exercises.count).to eq(1)
      expect(subject.duration).to eq(exercise.duration)

      WorkoutExercise.find_by(workout: subject, exercise: exercise).destroy!
      subject.reload

      expect(subject.exercises.count).to eq(0)
      expect(subject.duration).to eq(0)
    end
  end
end
