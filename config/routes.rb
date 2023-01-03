Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
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

  resources :posts do
    resources :likes, only: %i[new create destroy], shallow: true
    resources :comments, only: %i[new create destroy edit update], shallow: true
  end

  resources :stories, only: %i[new create destroy]

  namespace :api do
    namespace :v1 do
      resources :stories, only: %i[index show]
      resources :relationships, only: %i[index]
    end
  end

end
