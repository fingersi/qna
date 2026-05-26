require 'rails_helper'
require 'thinking_sphinx/test'
require 'database_cleaner/active_record'

ThinkingSphinx::Test.init
ThinkingSphinx::Test.start index: false

RSpec.configure do |config|
  config.use_transactional_fixtures = false

  config.before(:each) do |example|
    if example.metadata[:sphinx]
      DatabaseCleaner.strategy = :truncation
    else
      DatabaseCleaner.strategy = :transaction
    end
    DatabaseCleaner.start
  end

  config.after(:each) do
    DatabaseCleaner.clean
  end

  config.after(:suite) do
    ThinkingSphinx::Test.stop
  end
end