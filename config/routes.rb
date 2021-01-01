Rails.application.routes.draw do
  devise_for :users
  root to: 'words#index'
  resources :words do
    resources :favorites, only: [:create, :destroy]
  end
end
