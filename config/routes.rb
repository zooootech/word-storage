Rails.application.routes.draw do
  devise_for :users
  root to: 'words#index'
  resources :words do
    resources :favorites, only: [:create, :destroy]
    collection do
      get 'search'
    end
  end
  resources :users, only: :show
end
