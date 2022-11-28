Rails.application.routes.draw do
  devise_for :users

  root to: "home#index"

  get '/me', to: 'users#me', as: 'me'

  resources :event_types

  scope '/schedules/:id' do
    get   '/', to: 'schedules#show',   as: 'schedule'
    put   '/', to: 'schedules#update'
    patch '/', to: 'schedules#update'

    get '/reschedule', to: 'schedules#edit',    as: 'edit_schedule'
    get '/cancel',     to: 'schedules#destroy', as: 'destroy_schedule'
  end

  scope '/:username/:event_type' do
    get '/',  to: 'schedules#new',    as: 'new_schedule'
    post '/', to: 'schedules#create'
  end
end
