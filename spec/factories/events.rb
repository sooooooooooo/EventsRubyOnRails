FactoryBot.define do
  factory :event do
    name { "MyString" }
    date { "2019-10-15" }
    location { "MyString" }
    state { "MyString" }
    user { nil }
  end
end
