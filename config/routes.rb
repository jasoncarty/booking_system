Rails.application.routes.draw do

  scope module: 'public' do
    resources :users, only: [:index, :show, :edit, :update]
    resources :events, only: [:index, :show, :edit, :update] do
      post '/:id/book', to: 'events#book', as: 'book', on: :collection
      post '/:id/cancel', to: 'events#cancel', as: 'cancel', on: :collection
    end
    resources :calendars, only: [:index, :show]
    resources :event_attendees

    get "/my_calendar", to: "calendars#my_calendar", as: "my_calendar"

    # user verifcation
    get "/users/verify/:token",   to: "users#verify",       as: "user_verify"
    post "/users/verification/",  to: "users#verification", as: "user_verification"
  end

  namespace :admin do
    root 'events#index'
    resources :users do
      get "resend_confirmation", to: "users#resend_confirmation", as: "resend_confirmation", on: :member
    end
    resources :events do
      get "old_events", to: "events#old_events", as: "old_events", on: :collection
    end

    resources :event_attendees
    get "site_settings", to: "site_settings#edit", as: "site_settings"
    put "update_site_settings", to: "site_settings#update", as: "update_site_settings"
  end

  root 'public/events#index'

  # Sessions
  get '/login',     to: 'sessions#new',     as: 'login'
  post '/login',    to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy', as: 'logout'

  # Confirmations
  get '/confirmations_new',     to: 'confirmations#new',    as: 'confirmation_new'
  post '/confirmations_create', to: 'confirmations#create', as: 'confirmation_create'

  # Passwords
  get '/passwords_new',     to: 'passwords#new',    as: 'password_new'
  post '/passwords_create', to: 'passwords#create', as: 'password_create'
  get '/passwords_reset/:password_reset_token', to: 'passwords#reset', as: 'password_reset'
  post '/passwords_update', to: 'passwords#update', as: 'password_update'

end