Rails.application.routes.draw do
  devise_for :users
  root to: "questions#index"

  resources :questions, only: %i[ index show new create update destroy edit ] do
    resources :answers, shallow: true do
      member do
        post :set_best
        post :vote
      end
    end
  end
  resources :attachments, only: :destroy
  resources :links, only: :destroy
  resource :profile, only: :show
end
