Rails.application.routes.draw do
  get 'relationships/follow_user'
  get 'relationships/unfollow_user'
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get 'profile/:username' => 'users#profile', as: :profile
  post ':username/follow_user', to: 'relationships#follow_user', as: :follow_user
  post ':username/unfollow_user', to: 'relationships#unfollow_user', as: :unfollow_user
  get 'search_user/:q' => 'users#search_user', as: :search_user
  root to: 'users#index'

  resources :posts do
    resources :likes, only: %i[new create destroy], shallow: true
    resources :comments, only: %i[new create destroy edit update], shallow: true
  end
  resources :stories, only: %i[new create show destroy]
end
