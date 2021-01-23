# == Schema Information
#
# Table name: expertises
#
#  id         :bigint           not null, primary key
#  name       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
FactoryBot.define do
  factory :expertise do
    name { Faker::Esport.unique.game }
  end
end
