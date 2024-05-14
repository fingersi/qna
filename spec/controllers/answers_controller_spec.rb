require 'rails_helper'

RSpec.describe AnswersController, type: :controller do

  let(:question) { create(:question, :with_answers, answer_count: 5) }

  describe 'GET #index' do
    before { get :index, params: { question_id: question } }

    it 'assign question to @question' do
      expect(assigns(:question)).to eq question
    end

    it 'question has some answers' do
      expect(assigns(:question).answers).to match_array(question.answers)
    end

    it 'render index' do
      expect(response).to render_template :index
    end
  end

end
