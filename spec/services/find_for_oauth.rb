require 'rails_helper'

RSpec.describe FindForOauth do
  let!(:user) { create :user }
  let(:auth_data) { OmniAuth::AuthHash.new(provider: 'github', uid: '321', info: { email: user.email }) }
  subject { FindForOauth.new(auth_data) }

  context 'user has already authorized by oath provider' do
    it 'find oathprovider' do 
      user.oauthproviders.create(provider: auth_data.provider, uid: auth_data.uid)
      expect(subject.call).to eq user
    end
  end

  context 'user exist but has not authorized by oauthprovider' do
    it 'find user by data from indentity provider' do 
      user = subject.call
      authorization = user.oauthproviders.first

      expect(authorization.provider).to eq auth_data.provider
      expect(authorization.uid).to eq auth_data.uid
    end

    it 'new user has not been created' do
      expect { subject.call }.not_to change(User, :count)
    end

    it 'new oauthprovider has been created' do
      expect { subject.call }.to change(OAuthProvider, :count).by(1)
    end
  end

  context 'new user' do

    let(:auth_data) { OmniAuth::AuthHash.new(provider: 'github', uid: '324', info: { email: 'bbb@mail.com' }) }
    
    it 'creates new user' do
      expect { subject.call }.to change(User, :count).by(1)
    end

    it 'creates new oathprovider' do
      expect { subject.call }.to change(OAuthProvider, :count).by(1)
    end

    it 'find user by data from indentity provider' do 
      user = subject.call
      authorization = user.oauthproviders.first

      expect(authorization.provider).to eq auth_data.provider
      expect(authorization.uid).to eq auth_data.uid
    end

    it 'create new user with email from oath_data' do
      user = subject.call

      expect(user.email).to eq auth_data.info[:email]
    end
  end
end
