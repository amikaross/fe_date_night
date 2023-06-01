Rails.application.routes.draw do
  resources :sessions, only: [:create, :destroy]
  resources :users, only: [:new, :create, :update]
  resources :places, only: [:index, :show]
  resources :appointments, only: [:new, :create, :index]
  resources :favorites, only: [:index]

  get '/', to: 'welcome#index', as: :root
  get '/dashboard', to: 'users#show', as: :user_dashboard
end
