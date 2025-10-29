FactoryBot.define do
  factory :question do
    title { 'MyString' }
    body { 'MyText' }
    author
  end

  trait :invalid do
    body { nil }
  end

  trait :with_file do
    files { Rack::Test::UploadedFile.new("#{Rails.root}/spec/support/feature_helpers.rb", "file/rb") }
  end

  trait :with_links do
    transient do
      links_count { 2 }
    end

    after(:build) do |question, evaluator|
      evaluator.links_count.times do
        question.links.build(title: 'Example link', url: 'http://example.com')
      end
    end
  end

  trait :with_answers do
    transient do
      count { 2 }
    end

    after(:build, :create) do |question, evaluator|
      create_list(
        :answer,
        evaluator.count,
        question: question
      )
    end
  end
end
