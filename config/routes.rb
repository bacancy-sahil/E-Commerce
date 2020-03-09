Rails.application.routes.draw do
  resources :order_histories
  resources :likes
  resources :mappingtables
  devise_for :users
  resources :users
  get 'client/cart'
  get 'client/orderConfirm'
  # resources :client
  # post '/client/create' => "client#create", :as => :create_brnad
  post 'client/create', as: :client_create
  get 'brands/status' => "brands#status" , as: :status
  get 'brands/subscription' =>  "brands#subscription" ,as: :brands_subscription
  get 'products/get_sub_category' =>  "products#get_sub_category"
  get 'client/AddToCart'
  post '/client/updateLike'  
  get '/client/deleteComment'
  root "client#home" ,as: :client_home
  get '/client/product' 
  get '/client/subCategory'
  get '/client/brand'
  get "/client/updateCartValue"
  get "/client/category"
  get "/client/addComment"
  get "/client/updateComment"
  post 'client/deleteCart' ,as: :client_deleteCart
  resources :comments
  resources :carts
  resources :areas
  resources :cities
  resources :states
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
