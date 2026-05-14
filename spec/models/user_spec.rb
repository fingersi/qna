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

end
