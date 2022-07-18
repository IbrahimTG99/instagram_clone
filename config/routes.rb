Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  # dashboard
  get '/dashboard' => 'users#index'
  root to: 'public#homepage'
  resources :posts, only: %i[new create show]
end
