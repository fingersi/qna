require 'rails_helper'

RSpec.describe AnswersController, type: :controller do

  let(:question) { create(:question, :with_answers, count: 2) }
  let(:user) { create(:user) }

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

  describe 'GET #new' do
    before { login(user) }
    before { get :new, params: { question_id: question } }

    it 'assigns new answer to @answer' do
      expect(assigns(:answer)).to be_a_new(Answer)
    end

    it 'render view new' do
      expect(response).to render_template :new 
    end
  end

  describe 'POST #create' do
    before { login(user) }
    let(:question) { create(:question) }

    context 'valid attributes' do
      it 'should create answer with valid attributes' do
        expect { post :create, params: { question_id: question, body: build(:answer).body, author: user }, format: :js }.to change(Answer, :count).by(1)
      end

      it 'render redirect to question_path' do
        post :create, params: { question_id: question.id, body: build(:answer).body, author: user }, format: :js
        expect(response).to redirect_to(question_answers_path(question))
      end
    end

    context 'invalid attributes' do
      it 'should not create answer with invalid paramets' do
        expect { post :create, params: { question_id: question, answer: attributes_for(:answer, :invalid) }, format: :js}.not_to change(Answer, :count)
      end

      it 'render :new template' do
        post :create, params: { question_id: question, answer: attributes_for(:answer, :invalid), format: :js }
        expect(response).to render_template :create
      end
    end
  end

  describe 'PATCH #edit' do
    before { login(user) }
    let(:question) { create(:question) }
    let!(:answer) { create(:answer, question: question) }

    context 'valid attributes' do
      it 'should update answer with valid attributes' do
        patch :update, params: { id: answer,  answer: { body: 'updated answer' }, format: :js }
        answer.reload
        expect(answer.body).to eq 'updated answer'
      end

      it 'renders template update' do
        patch :update, params: { id: answer,  answer: { body: 'updated answer' }, format: :js }
        expect(response).to render_template :update
      end
    end

    context 'invalid attributes' do
      it 'should not update answer with invalid paramets' do
        expect do 
          patch :update, params: { id: answer, answer: attributes_for(:answer, :invalid), format: :js }
        end.to_not change(answer, :body)
      end

      it 'render :new template' do
        patch :update, params: { id: answer, answer: attributes_for(:answer, :invalid), format: :js }
        expect(response).to render_template :update
      end
    end
  end
end
