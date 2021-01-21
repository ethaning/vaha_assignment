FactoryBot.define do
  factory :user do
    first_name { "MyString" }
    last_name { "MyString" }
    email { "MyString" }
    expertise { nil }
  end
end
