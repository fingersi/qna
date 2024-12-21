FactoryBot.define do
  factory :question do
    title { "MyString" }
    body { "MyText" }
    author
  end

  trait :invalid do
    body { nil }
  end

  trait :with_answers do
    transient do
      count { 2 }
    end

    after(:build, :create) do |question, evaluator|      
      create_list( 
        :answer,
        evaluator.count,
        question: question,
      )
    end
  end
end
