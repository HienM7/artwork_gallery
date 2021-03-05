Rails.application.routes.draw do
  root to: 'artworks#index', as: 'home'

  devise_for :users, controllers: { registrations: 'registrations' }

  namespace :admin do
    resources :categories
    resources :tags
    resources :users
  end

  get '/my/profile', to: 'admin/users#show_my_profile', as: 'my_profile'
  get '/users/:id/profile', to: 'admin/users#show_profile', as: 'user_profile'

  resources :artworks

  post 'artworks/:id/download', to: 'artworks#download', as: 'download'
  post 'artworks/:id/toggle_pub', to: 'artworks#toggle_pub_status', as: 'toggle_pub'
  get 'my/artworks', to: 'artworks#my_artworks', as: 'show_my_artworks'
  # get 'my/artworks/new', to: 'artworks#new', as: 'my_artworks'

  resources :users do
    resources :artworks do
      resources :favorites
    end
  end
end
