require 'sphinx_helper'

RSpec.describe SearchController, type: :controller, sphinx: true do

  describe 'GET #index' do
    let(:user) { create(:user) }

    before { login(user) }

    context 'GET#SEARCH' do
      let!(:question) { create(:question, title: 'Sphinx controller test query', author: user) }
      let!(:answer) { create(:answer, body: 'Sphinx controller answer text', question: question, author: user) }
      let!(:comment) { create(:comment, body: 'Sphinx controller comment text', commentable: question, user: user) }

      before do
        ThinkingSphinx::Test.index
        sleep 1
      end

      it 'respond with question' do
        get :index, params: { q: 'Sphinx controller test query' }

        expect(assigns(:results).to_a).to include(question)
        expect(response).to render_template :index
      end

      it 'respond with answer with scope answers' do
        get :index, params: { q: 'Sphinx controller answer', scope: 'answers' }

        expect(assigns(:results).to_a).to include(answer)
        expect(assigns(:results).to_a).not_to include(question)
      end

      it 'respond with comment with scope comments' do
        get :index, params: { q: 'Sphinx controller comment', scope: 'comments' }

        expect(assigns(:results).to_a).to include(comment)
        expect(assigns(:results).to_a).not_to include(question)
      end
    end
  end
end
