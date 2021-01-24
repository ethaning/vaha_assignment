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
FactoryBot.define do
  factory :workout do
    name { "#{Faker::JapaneseMedia::SwordArtOnline.game_name} Workout" }
    association :creator, factory: :trainer
    duration { 0 }
    state { 0 }

    trait :with_exercise do
      association :creator, factory: :trainer, strategy: :create

      after(:create, :build) do |workout, _|
        workout.exercises << create(:exercise)
      end
    end
  end
end
