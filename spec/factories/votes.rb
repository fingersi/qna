FactoryBot.define do
  factory :vote do
    user { nil }
    answer { nil }
    value { false }
  end
end
