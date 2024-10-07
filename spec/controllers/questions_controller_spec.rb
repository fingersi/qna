require 'rails_helper'

RSpec.describe QuestionsController, type: :controller do

  let(:question) { create(:question) }
  let(:user) { create(:user) }

  describe 'GET #new' do
    before { login(user) }
    before { get :new }
    it 'assigns new question to new @Question' do
      expect(assigns(:question)).to be_a_new(Question)
    end

    it 'render view new' do
      expect(response).to render_template :new 
    end
  end

  describe 'POST #create ' do  
    before { login(user) }
    context 'with valid params' do
      it 'create question with valid date' do
        expect { post :create, params: { question: attributes_for(:question) } }.to change(Question, :count).by(1)
      end

      it 'redirects to show view' do
        post :create, params: { question: attributes_for(:question) }
        expect(response).to redirect_to assigns(:question)
      end
    end

    context 'with invalid params' do
      it 'do not save question with invalid params' do
        expect { post :create, params: { question: attributes_for(:question, :invalid) } }.to_not change(Question, :count)
      end

      it 'render to new' do
        post :create, params: { question: attributes_for(:question, :invalid) }
        expect(response).to render_template :new
      end
    end
  end

  describe 'GET #show' do
    before { get :show, params: { id: question } }

    it 'assign requested question to @question' do
      expect(assigns(:question)).to eq question
    end

    it 'render show' do
      expect(response).to render_template :show
    end
  end

  describe 'GET #index' do
    let(:questions) { create_list(:question, 3) }

    before { get :index }

    it 'get all question' do
      expect(assigns(:questions)).to match_array(questions)
    end

    it 'render index' do
      expect(response).to render_template :index
    end
  end
  
end
