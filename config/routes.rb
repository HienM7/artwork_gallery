Rails.application.routes.draw do
  resources :artworks
  resources :categories

  # namespace :admin do
  #   root to: "admin#index"
  # end

  root to: 'artworks#index'
end
