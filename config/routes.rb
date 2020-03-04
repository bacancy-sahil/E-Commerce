Rails.application.routes.draw do
  devise_for :users
  resources :users
  get 'user1s/cart'
  get 'brands/status' => "brands#status" , as: :status
  get 'brands/subscription' =>  "brands#subscription" ,as: :brands_subscription
  get 'products/get_sub_category' =>  "products#get_sub_category"
  get 'user1s/AddToCart'
  post 'user1s/orderConfirm' =>  "user1s#orderConfirm"
  
  root "user1s#home" ,as: :user1s_home


  get "user1s/updateCartValue"

  post 'user1s/deleteCart' ,as: :user1s_deleteCart
  resources :news_letters
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
  get 'user1s/checkout',as: :user1s_checkout
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
