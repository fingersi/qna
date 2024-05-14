FactoryBot.define do
  factory :question do
    title { "MyString" }
    body { "MyText" }
  end

  trait :invalid do
    body { nil }
  end

  trait :with_answers do
    transient do
      answer_count {2}
    end

    after(:build, :create) do |question, evaluator|
      create_list( 
        :answer,
        evaluator.answer_count,
        question: question
      )
    end
  end

end
