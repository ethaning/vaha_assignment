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
FactoryBot.define do
  factory :exercise do
    name { Faker::JapaneseMedia::DragonBall.unique.race }
    duration { rand(60) + 15 }
  end
end
