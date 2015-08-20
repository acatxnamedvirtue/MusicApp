Rails.application.routes.draw do
  resources :users, only: [:index, :show, :create, :new]
  resource :session, only: [:create, :new, :destroy]

  resources :bands do
    resources :albums, only: :new
  end

  resources :albums, except: [:new, :index] do
    resources :tracks, only: :new
  end

  resources :tracks, except: :new do
    resources :notes, only: :new
  end

  resources :notes, only: [:show, :create, :destroy]

  root "bands#index"
end
