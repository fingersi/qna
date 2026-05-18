FactoryBot.define do
  factory :link do
    title { "Ruby" }
    url { "www.ruby-lang.org" }
    linkable { nil }
  end

  trait :with_answer_author do
      transient do
        author { nil } 
      end

    linkable { association :answer, author: author }
  end

  trait :with_question do
    association :linkable, factory: :question
  end
end
