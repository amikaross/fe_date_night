Rails.application.routes.draw do
  resources :sessions, only: [:create]

  get '/', to: 'welcome#index'
  get '/dashboard', to: 'users#show', as: :user_dashboard
end
