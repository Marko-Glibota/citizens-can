Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'users/registrations' }
  root to: 'pages#home'
  resources :representatives, only: [:index, :show] do
    collection do
      get :search
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
