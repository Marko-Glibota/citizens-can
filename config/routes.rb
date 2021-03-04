Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'users/registrations' }
  root to: 'pages#home'
  get 'manifesto', to: 'pages#manifesto', as: :manifesto
  resources :representatives, only: [:index, :show] do
    collection do
      get :search
    end
    member do
      post :user_request
    end
    resources :reprensatives_votes, only: [:new, :create]
  end
  resources :laws, only: [:index, :show] do
    member do
      get "for" => "laws#for"
      get "against" => "laws#against"
    end
    resources :comments, only: [:create]
    resources :users_votes, only: [:new, :create]
  end
end
