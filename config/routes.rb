Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  get '/dashboard' => 'users#index'
  get 'profile/:username' => 'users#profile', as: :profile
  root to: 'public#homepage'

  resources :posts, only: %i[new create show] do
    resources :likes, only: %i[new create destroy], shallow: true
  end
end
