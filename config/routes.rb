Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'users#show', as: 'home'
  post 'xulylogin' => 'users#xulylogin'
  get 'login' => 'users#login'
  resources :users
end
