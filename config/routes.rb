Rails.application.routes.draw do
  root to: 'users#index'
  resources :questions, except: %i[index show new]
  resource :session, only: %i[new create destroy]
  resources :users
end
