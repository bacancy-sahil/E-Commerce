# frozen_string_literal: true

Rails.application.routes.draw do
  resources :pendingpayments
  resources :orders
  resources :order_histories
  resources :likes
  resources :mappingtables
  devise_for :users
  resources :users
  resources :charges
  get '/admins/update_order_status'
  get '/client/filterdatabyCat'
  get '/client/filterdata'
  get '/brands/dashboard'
  get '/admins/index'
  get '/newsletters/sendmessage'
  get '/newsletters/send'
  get '/client/profile'
  get '/client/updateProfile'
  get 'client/cart'
  get 'client/orderConfirm'
  # resources :client message
  # post '/client/create' => "client#create", :as => :create_brnad
  get '/newsletters/create'
  get '/client/search'
  post 'client/create', as: :client_create
  get 'brands/status' => 'brands#status', as: :status
  get 'brands/subscription' => 'brands#subscription', as: :brands_subscription
  get 'products/get_sub_category' => 'products#get_sub_category'
  get 'client/AddToCart'
  post '/client/updateLike'
  get '/client/deleteComment'
  root 'client#home', as: :client_home
  get '/client/product'
  get '/client/subCategory'
  get '/client/brand'
  get '/client/updateCartValue'
  get '/client/category'
  get '/client/addComment'
  get '/client/updateComment'
  post 'client/deleteCart', as: :client_deleteCart
  get '/brands/done'
  get '/admins/approval'
  resources :comments
  resources :carts
  resources :brands
  resources :subscriptions
  resources :products
  resources :sub_categories
  resources :categories
  get '/client/checkout'
  get '/client/orderHistorys'
  get '/client/orderHistory'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
