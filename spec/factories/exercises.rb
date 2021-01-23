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
FactoryBot.define do
  factory :exercise do
    name { Faker::JapaneseMedia::DragonBall.unique.race }
    duration { rand(60) + 15 }
  end
end
