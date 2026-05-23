require 'sidekiq/web'

Rails.application.routes.draw do
  mount Sidekiq::Web => '/sidekiq'
  
  use_doorkeeper
  devise_for :users, controllers: { omniauth_callbacks: 'oauth_callbacks'}
  root to: "questions#index"

  resources :questions, only: %i[ index show new create update destroy edit ] do
    resources :subscriptions, only: [:create, :destroy], shallow: true
    resources :comments, only: %i[create destroy], defaults: { commentable: 'questions' }
    resources :answers, shallow: true do
      member do
        post :set_best
        post :vote
      end
      resources :comments, only: %i[create destroy], defaults: { commentable: 'answers' }
    end
  end

  namespace :api do
    namespace :v1 do
      resources :profiles, only: [] do
        get :me, on: :collection
        get :other_users, on: :collection
      end

      resources :questions
    end
  end
 
  resources :attachments, only: :destroy
  resources :links, only: :destroy
  resource :profile, only: :show

  mount ActionCable.server => '/cable'

  get '/.well-known/appspecific/com.chrome.devtools.json', to: ->(_) { [204, {}, ['']] }
end
