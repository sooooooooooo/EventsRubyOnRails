FactoryBot.define do
  factory :comment do
    comment { "MyText" }
    user { nil }
    event { nil }
  end
end
