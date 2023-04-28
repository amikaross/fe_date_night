Rails.application.routes.draw do
  resources :sessions, only: [:create]
  resources :users, only: [:new, :create]

  get '/', to: 'welcome#index', as: :root
  get '/dashboard', to: 'users#show', as: :user_dashboard
end
