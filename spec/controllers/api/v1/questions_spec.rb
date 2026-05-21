require 'rails_helper'

RSpec.describe 'Questions API', type: :request do
  let(:headers) {  { "CONTENT_TYPE" => "application/json",
                      "ACCEPT" => 'application/json' } }


  let(:question_params) { { title: 'Valid Title',
                          body: 'Valid Body', 
                          "links_attributes": [{ 
                          "title": "Rails docs", 
                          "url": "https://rubyonrails.org" }] } }

  let(:question_attrs) { %w[id title body author_id created_at updated_at] }
  let(:answer_attrs) { %w[id body author_id created_at updated_at] }

  context 'GET Questions' do
    let(:user) { create(:user) }
    let(:other_user) { create(:user) }
    let(:oauth_application) { create(:oauth_application) }
    let(:access_token) { create(:access_token, application: oauth_application, resource_owner_id: user.id, scopes: 'write') }
    let(:other_access_token) { create(:access_token, application: oauth_application, resource_owner_id: other_user.id, scopes: 'write') }
    let!(:questions) { create_list(:question, 2, author: user ) }
    let!(:question) { questions.first }
    let!(:link) {create :link, linkable: question }
    let!(:answers) { create_list(:answer, 4, question: question) }
    let(:question_in_responce) { json['questions'].first }
   
    it_behaves_like 'api authorizable' do
      let(:method) { :get }
      let(:api_path) { '/api/v1/questions' }
    end

    before { get '/api/v1/questions', params: { access_token: access_token.token }, headers: headers }

    context 'check questions' do
      it_behaves_like 'Api request' do
        let(:json_object){ json['questions'].first }
        let(:entity){ question } 
        let(:attributes) { question_attrs }
      end

      it 'return all questions' do
        expect(json['questions'].length).to be questions.length
      end 

      it_behaves_like 'Linkable' do
        let(:json_object) { json['questions'].first }
        let(:entity) { question.links }
      end

      context 'check answers' do
        let(:answer) { answers.first }
        let(:answer_in_response) { question_in_responce['answers'].first }

        it 'return all answers' do
          expect(json['questions'].first['answers'].length).to eq question.answers.length
        end
      end
    end

    context 'get question' do
      let!(:question) { create :question, author: user }
      let(:question_in_response) { json['question'] }
        
      it_behaves_like 'api authorizable' do
        let(:method) { :get }
        let(:api_path) { "/api/v1/questions/#{question.id}" }
      end

      before { get "/api/v1/questions/#{question.id}", params: { access_token: access_token.token }, headers: headers }

      it 'returns right fields for link' do 
        check_attrs(question_in_response['links'].first, link, %w[id title url created_at updated_at])
      end


      it 'returns right fields for question' do 
        check_attrs(question_in_response, question, %w[id title body links created_at updated_at])
      end

      it 'any user have access can read question' do
        get "/api/v1/questions/#{question.id}", params: { access_token: other_access_token.token }, headers: headers 
        check_attrs(question_in_response, question, %w[id title body links created_at updated_at])
      end
    end

    context 'create(post question)' do

      it_behaves_like 'api authorizable' do
        let(:method) { :post }
        let(:api_path) { "/api/v1/questions" }
      end

      before { post '/api/v1/questions', 
               params: { access_token: access_token.token, question: question_params }.to_json, 
               headers: headers }
      
      it 'returns successful status' do
        expect(response).to be_successful
      end

      it 'returns right attributes for question' do
        check_attrs(json['question'], Question.last, %w[id title body author_id created_at updated_at])
      end

      it 'link was created and return in response' do
        expect(Link.last.title).to eq "Rails docs"
        expect(Link.last.url).to eq "https://rubyonrails.org"
        check_attrs(json['question']['links'].first, Link.last, %w[id title url created_at updated_at])
      end

      it 'saves the question in the database' do
        expect(Question.last.title).to eq 'Valid Title'
        expect(Question.last.body).to eq 'Valid Body'
      end
    end

    context 'PATCH question' do
      let!(:question_update) { create :question, author: user }

      it_behaves_like 'api authorizable' do
        let(:method) { :patch }
        let(:api_path) { "/api/v1/questions/#{question_update.id}" }
      end

      before { patch "/api/v1/questions/#{question_update.id}", 
               params: { access_token: access_token.token, question: question_params }.to_json, 
               headers: headers }

      it 'returns successful status' do
        expect(response).to be_successful
      end

      it 'saved new field for queston' do
        expect(Question.find(question_update.id).title).to eq question_params[:title]
        expect(Question.find(question_update.id).body).to eq question_params[:body]
      end

      it 'saves new link' do
        expect(Question.find(question_update.id).links.first.title).to eq question_params[:links_attributes].first[:title]
        expect(Question.find(question_update.id).links.first.url).to eq question_params[:links_attributes].first[:url]
      end

      it 'returns right field for updated question' do
        check_attrs(json['question'], Question.find(question_update.id), %w[id body title author_id links created_at updated_at])
      end

      it 'only author can update question' do
        patch "/api/v1/questions/#{question_update.id}", 
               params: { access_token: other_access_token.token, question: question_params }.to_json, 
               headers: headers

        expect(response.status).to eq 403
      end
    end

    context 'DELETE QUESTION' do
      let!(:question_delete) { create :question, author: user}
      let!(:admin) { create(:user, admin: true ) }
      let!(:admin_access_token) { create( :access_token, 
                                    application: oauth_application,
                                    resource_owner_id: admin.id,
                                    scopes: 'write') }

      
      context 'Author cannot delete question'   
      
        before do
          delete "/api/v1/questions/#{question_delete.id}", 
          params: { 
            access_token: access_token.token
          }.to_json,
          headers: headers
        end

        it 'only admin can delete question' do
          expect(response.status).to eq 403
          expect(Question.find(question_delete.id)).to eq question_delete
        end

        it 'Question stil in DB' do
          expect(Question.exists?(question_delete.id)).to be_truthy
        end
      
      context 'Admin can delete question' do
        before do
          delete "/api/v1/questions/#{question_delete.id}", 
                params: { 
                  access_token: admin_access_token.token
                }.to_json, 
                headers: headers
        end

        it 'returns successful status' do
          expect(response).to be_successful
        end

        it 'returns right filed' do
          check_attrs(json, question_delete, %w[id])
        end

        it 'removes question from DB' do
          expect(Question.exists?(question_delete.id)).to be_falsey
        end
      end
    end
  end

end