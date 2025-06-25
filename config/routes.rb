Rails.application.routes.draw do

  devise_for :users
  root to: "questions#index"

  resources :questions, only: %i[ index show new create update destroy edit ] do
    resources :answers, shallow: true do
      post 'set_best', to: 'answers#set_best' 
    end
  end
  delete 'attachment/:id/delete', to: 'attachment#delete', as: 'delete_attachment'
end
