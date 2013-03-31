ConferenceApp::Application.routes.draw do
  #order stuff
  get "orders" => "orders#index"
  get "orders/new_user"
  post "orders/add_user"
  get "orders/show"
  get "orders/complete"

  get "orders/:id" => "orders#show"
  #map.conect "orders/:id", :controller => "orders", :action => "show"

  resources :talk_categories


  resources :talk_types


  get "talk/index"

  get "talk/destroy"

  get "home/index"
  root :to => "home#index"
  resources :tickets
  resources :talks
  resources :payment_notifications

  get "payments/paypal_completed"
  get "payments/create_paypal"
  get "payments/create_manual"
  get "payments/complete"
  resources :payments

  devise_for :users, :controllers => { :registrations => "registrations"}
  match "/users" => "users#index"
  match "/users/:id" => "users#destroy"
  match "users/complete/:id" => "users#complete"
  devise_for :users
  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
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

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  # root :to => 'welcome#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
