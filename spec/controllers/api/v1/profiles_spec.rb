require 'rails_helper'

RSpec.describe 'Profiles API', type: :request do
  let(:headers) {  { "CONTENT_TYPE" => "application/json",
                      "ACCEPT" => 'application/json' } }

  context 'method me' do
    it_behaves_like 'api authorizable' do
      let(:method) { :get }
      let(:api_path) { '/api/v1/profiles/me' }
    end

    context 'authorized' do
      let(:me) { create(:user) }
      let(:access_token) { create(:access_token, resource_owner_id: me.id) }

      before { get '/api/v1/profiles/me', params: { access_token: access_token.token }, headers: headers }

      it 'returns 200 status' do
        expect(response).to be_successful
      end

      it 'returns all public fields' do
        %w[id email admin created_at updated_at].each do |attr|
          expect(json[attr]).to eq me.send(attr).as_json
        end
      end

      it 'does not return private fields' do
        %w[password encrypted_password].each do |attr|
          expect(json).to_not have_key(attr)
        end
      end
    end
  end

  context 'method other_users' do
    let!(:users) { create_list :user, 3 }
    let(:access_token) { create(:access_token, resource_owner_id: users.first.id) }

    it_behaves_like 'api authorizable' do
      let(:method) { :get }
      let(:api_path) { '/api/v1/profiles/other_users' }
    end

    before { get '/api/v1/profiles/other_users', params: { access_token: access_token.token }, headers: headers }

    it 'returns all users' do
      expect(json.length).to eq (users.length - 1)
    end

    it 'return right field for user' do
      %w[id email admin created_at updated_at].each do |attr|
        expect(json.last[attr]).to eq users.last.send(attr).as_json
      end
    end

    it 'does not return private fields' do
      %w[password encrypted_password].each do |attr|
        expect(json.last).to_not have_key(attr)
      end
    end
  end

end