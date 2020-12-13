Rails.application.routes.draw do
  resources :categories

  get 'artworks/index'
  get 'artworks/show'
  # namespace :admin do
  #   root to: "admin#index"
  # end

  root to: 'artworks#index'
end
