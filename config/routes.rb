Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  # dashboard
  get '/dashboard' => 'users#index'
  get 'profile/:username' => 'users#profile', as: :profile
  get 'post/like/:post_id' => 'likes#save_like', as: :like_post
  root to: 'public#homepage'
  resources :posts, only: %i[new create show]
end
