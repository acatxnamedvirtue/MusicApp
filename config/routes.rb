Rails.application.routes.draw do
  resources :users, only: [:create, :new, :destroy]
  resource :session, only: [:create, :new, :destroy]
end
