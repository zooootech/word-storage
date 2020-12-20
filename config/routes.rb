Rails.application.routes.draw do
  devise_for :users
  root to: 'words#index'
  resources :words, only: [:index, :new, :create]
end
