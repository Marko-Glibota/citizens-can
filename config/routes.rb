Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  resources :representative, only: [:show] do
    resources :reprensatives_votes, only: [:new, :create]
  end
  resources :law, only: [:index, :show] do
    resources :comment, only: [:new, :create]
    resources :users_votes, only: [:new, :create]
  end
end
