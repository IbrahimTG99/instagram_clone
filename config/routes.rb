Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
<<<<<<< Updated upstream
  get 'profile/:username' => 'users#profile', as: :profile
  post ':username/follow_user', to: 'relationships#follow_user', as: :follow_user
  post ':username/unfollow_user', to: 'relationships#unfollow_user', as: :unfollow_user
  get 'search_user/:q' => 'users#search_user', as: :search_user
  root to: 'users#index'
=======

  devise_for :users

  get 'profile/:username' => 'users#profile', as: :profile

  root to: 'users#index'

  resources :users do
    collection do
      get 'search/:q' => 'users#search', as: :search
    end

    member do
      post 'follow', to: 'relationships#follow_user'
      post 'unfollow', to: 'relationships#unfollow_user'
      post 'accept_follow', to: 'relationships#accept_follow'
      post 'reject_follow', to: 'relationships#reject_follow'
    end
  end
>>>>>>> Stashed changes

  resources :posts do
    resources :likes, only: %i[new create destroy], shallow: true
    resources :comments, only: %i[new create destroy edit update], shallow: true
  end
  resources :stories, only: %i[new create show destroy]
end
