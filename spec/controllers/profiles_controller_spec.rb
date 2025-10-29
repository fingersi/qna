require 'rails_helper'

RSpec.describe ProfilesController, type: :controller do
  let(:user) { create(:user) }
  describe 'GET #profile' do
    before { login(user) }
    before { get :show }

    it 'render profile show' do
      expect(response).to render_template :show
    end
  end
end
