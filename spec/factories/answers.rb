FactoryBot.define do
  factory :answer do
    body { 'String' }
    question
    author
  end

  trait :invalid_answer do
    body { nil }
  end

end
