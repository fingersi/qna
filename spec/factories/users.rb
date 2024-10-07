FactoryBot.define do
  sequence :email do |n|
    "test#{n}@mail.com"
  end
  factory :user, aliases: [:author] do 
    email
    password { 'aabbcc' }
    password_confirmation { 'aabbcc' }
  end
end
