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
    resources :users
    resources :events do
      get "old_events", to: "events#old_events", as: "old_events", on: :member, on: :collection
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


  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
