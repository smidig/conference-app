ConferenceApp::Application.routes.draw do
  root :to => "info#index"

  #MyProfile
  get "my-profile/dinner_registration" => "my_profile#dinner_registration"
  get "my-profile/receipt" => "my_profile#receipt"
  resources :my_profile, :only => "index"

  #order stuff
  get "orders/new_user"
  post "orders/add_user"
  get "orders/show"
  resources :orders, :only => [:index, :show, :destroy]

  resources :sponsors

  get "administration/registrations"
  get "administration/send_mail"
  get "administration/statistics"

  #Info sites
  get "info/about"
  get "info/sponsor"
  get "info/index"
  get "info/policy"

  resources :talk_categories

  resources :talk_types

  # Can these be deleted?
  get "talk/index"
  get "talk/destroy"
  resources :talks

  resources :tickets


  resources :payment_notifications

  # payment stuff
  get "payments/paypal_completed"
  get "payments/manual_completed"
  get "payments/new_paypal"
  get "payments/new_manual"
  post "payments/create_manual"
  get "payments/complete"
  get "payments/manual"
  get "payments/finish"
  put "payments/invoice_sent"
  resources :payments

  # user stuff
  devise_for :users, :controllers => { :registrations => "registrations"}
  get "users/make_admin"
  match "users/complete/:id" => "users#complete"
  resources :users
  get "users/delete/:id" => "users#delete"
end
