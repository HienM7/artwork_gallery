Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'registrations' }
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  # namespace :admin do
  #   root to: "admin#index"
  # end
  scope '/admin' do
    resources :categories
    resources :users
  end

  resources :artworks

  # resources :categories, only: [:index]

  root to: 'artworks#index', as: 'home'

  post 'artworks/:id/download', to: 'artworks#download', as: 'download'
  get 'my/artworks', to: 'artworks#my_artworks', as: 'show_my_artworks'
  # get 'my/artworks/new', to: 'artworks#new', as: 'show_my_artworks'

  resources :users do
    resources :artworks do
      resources :favorites
    end
  end
end
