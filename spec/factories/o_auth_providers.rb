FactoryBot.define do
  factory :o_auth_provider do
    user { nil }
    provider { "MyString" }
    uid { "MyString" }
  end
end
