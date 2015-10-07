Rails.application.routes.draw do

  scope module: 'public' do
    resources :users, only: [:index, :show, :edit, :update]
    resources :events, only: [:index, :show, :edit, :update] do
      get "show_events/:id", to: "events#show_event", as: "show_event", on: :member, on: :collection
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

    resources :calendars
    resources :event_attendees
  end

  root 'public/events#index'

  # Sessions
  get '/login',     to: 'sessions#new', as: 'login'
  post '/login',    to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy', as: 'logout'


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
