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
  
  root to: 'artworks#index', as: 'home'
  
  post 'artworks/:id/download', to: 'artworks#download', as: 'download'

  resources :users do
    resources :artworks do
      resources :favorites
    end
  end
end
