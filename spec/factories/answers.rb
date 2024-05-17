FactoryBot.define do
  factory :answer do
    body { "String" }
    question
  end

  trait :invalid_answer do
    body { nil }
  end

end
