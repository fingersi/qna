require 'rails_helper'

RSpec.describe AnswersController, type: :controller do

  describe 'GET #index' do
    let(:question) { create(:question, :with_answers, answer_count: 2) }

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

  describe 'POST #create' do
    let(:question) { create(:question) }

    context 'valid attributes' do
      it 'should create answer with valid attributes' do
        expect { post :create, params: { question_id: question, answer: attributes_for(:answer) } }.to change(Answer, :count).by(1)
      end

      it 'render redirect to question_answer_path' do
        post :create, params: { question_id: question.id, answer: attributes_for(:answer) }
        expect(response).to redirect_to(question_answer_path(assigns(:question), assigns(:answer)))
      end
    end

    context 'invalid attributes' do
      it 'should not create answer with invalid paramets' do
        expect { post :create, params: { question_id: question, answer: attributes_for(:answer, :invalid) } }.not_to change(Answer, :count)
      end

      it 'render :new template' do
        post :create, params: { question_id: question, answer: attributes_for(:answer, :invalid) }
        expect(response).to render_template :new
      end
    end
  end

end
