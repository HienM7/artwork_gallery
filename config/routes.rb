Rails.application.routes.draw do
  root to: 'artworks#index', as: 'home'

  devise_for :users, controllers: { registrations: 'registrations' }

  scope '/admin' do
    # resources :categories, only: [:index]
    resources :categories
    resources :tags
    resources :users
  end

  resources :artworks

  post 'artworks/:id/download', to: 'artworks#download', as: 'download'
  get 'my/artworks', to: 'artworks#my_artworks', as: 'show_my_artworks'
  # get 'my/artworks/new', to: 'artworks#new', as: 'show_my_artworks'

  resources :users do
    resources :artworks do
      resources :favorites
    end
  end
end
