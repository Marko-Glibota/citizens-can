Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  resources :representatives, only: [:show] do
    collection do
      get :search
    end
    resources :reprensatives_votes, only: [:new, :create]
  end
  resources :laws, only: [:index, :show] do
    member do
      put "like" => "laws#upvote"
      put "unlike" => "laws#downvote"
      put "for" => "laws#for"
      put "against" => "laws#against"
    end
    resources :comments, only: [:create]
    resources :users_votes, only: [:new, :create]
  end
end
