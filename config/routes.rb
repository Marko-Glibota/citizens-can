Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  resources :representatives, only: [:show] do
    resources :reprensatives_votes, only: [:new, :create]
  end
  resources :laws, only: [:index, :show] do
    resources :comments, only: [:new, :create]
    resources :users_votes, only: [:new, :create]
  end
end
