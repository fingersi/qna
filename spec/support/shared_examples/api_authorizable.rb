RSpec.shared_examples 'api authorizable' do
  context 'unauthorized' do
    it 'returns 401 status if there is no access_token' do
      sent_request(method, api_path, headers: headers)
      expect(response.status).to eq 401
    end

    it 'returns 401 status if access_token is invalid' do
      sent_request(method, api_path, params: { access_token: '1234' }.to_json, headers: headers)
      expect(response.status).to eq 401
    end
  end
end

RSpec.shared_examples 'Api request' do
  context 'returns 200' do
      it 'returns 200 status' do
        expect(response).to be_successful
      end

    it 'returns right attributes' do
      check_attrs(json_object, entity, attributes)
    end
  end
end



