Rails.application.routes.draw do
  devise_for :users
  root to: "questions#index"

  resources :questions, only: %i[ index show new create update destroy edit ] do
    resources :comments, only: %i[create destroy]

    resources :answers, shallow: true do
      post 'set_best', to: 'answers#set_best' 
      post 'vote', to: 'answers#vote'

      resources :comments, only: %i[create destroy]
    end
  end
  resources :attachments, only: :destroy
  resources :links, only: :destroy
  resource :profile, only: :show

  mount ActionCable.server => '/cable'

  get '/.well-known/appspecific/com.chrome.devtools.json', to: ->(_) { [204, {}, ['']] }
end
