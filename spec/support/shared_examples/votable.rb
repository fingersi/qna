require 'rails_helper'

shared_examples_for 'Votable' do
    describe 'POST #vote' do

    let(:user) { create(:user) }
    let(:author) { create(:user) }
    let(:question) { create(:question) }
    let(:answer) { create(:answer, question: question, author: author) }

    before { login(user) }

    it 'create new Vote' do
      expect { post :vote, params: { id: answer.id, decision: true  } }.to change(Vote, :count).by(1)
    end 

  end

    describe 'POST #vote author votes' do

    let(:author) { create(:user) }
    let(:question) { create(:question) }
    let(:answer) { create(:answer, question: question, author: author) }

    before { login(author) }

    it 'create new Vote' do
      expect { post :vote, params: { id: answer.id, decision: true  } }.to change(Vote, :count).by(0)
    end 
  end

end