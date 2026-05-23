require 'rails_helper'

RSpec.describe User, type: :model do
  it { should validate_presence_of :email }
  it { should validate_presence_of :password }
  it { should have_many(:oauthproviders).dependent(:destroy) }

  describe '.find user by oauth data' do
    let!(:user) { create :user }
    let(:auth_data) { OmniAuth::AuthHash.new(provider: 'github', uid: '321', info: { email: user.email }) }
    let(:service) { double('FindForOauth double') }
  
    it 'call FindForAuth' do 
      expect(FindForOauth).to receive(:new).with(auth_data).and_return(service)
      expect(service).to receive(:call)
      User.find_for_oauth(auth_data)
    end
  end

  describe 'find_subscription by question' do
    let!(:user) { create :user }
    let(:question) { create :question }
    let(:subcription) { create :subscription, question: question, user: user }

    it 'returns subscription' do
      expect(user).to receive(:find_subscription).with(question).and_return(subcription)
      user.find_subscription(question)
    end
  end

end
