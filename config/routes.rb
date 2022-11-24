Rails.application.routes.draw do
  devise_for :users

  root to: "home#index"

  get '/me', to: 'users#me', as: 'me'

  resources :event_types

  resources :schedules, except: %i[ new create ]
  scope '/:username/:event_type' do
    get '/', to: 'schedules#new', as: 'new_schedule'
    post '/', to: 'schedules#create'
  end
end
