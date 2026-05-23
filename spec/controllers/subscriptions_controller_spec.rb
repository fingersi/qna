require 'rails_helper'

RSpec.describe SubscriptionsController, type: :controller do
  let(:author) { create :user  }
  let(:question) { create(:question, author: author) }
  let(:user) { create :user }

  describe 'POST #create ' do
    before { login(author) }


    context 'with valid params' do
      it 'create subscription with valid attributes' do
        expect { post :create, params: { question_id: question.id } }.to change(Subscription, :count).by(1)
      end

      it 'redirects to Question#Show view' do
        post :create, params: { question_id: question.id }
        expect(response).to redirect_to assigns(:question)
      end
    end
  end

  describe 'DELETE# destroy' do
    before { login(user)}
    let(:subscription) { create :subscription, user: user, question: question }

    it "destroys subcription" do
      expect {
      delete :destroy, params: { id: subscription.id  }
      }.to change(Subscription, :count).by(1)
    end
  end
end
