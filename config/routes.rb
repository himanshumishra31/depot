Rails.application.routes.draw do
  resources :categories
  get 'admin' => 'admin#index'

  controller :sessions do
    get 'login' => :new
    post 'login' => :create
    delete 'logout' => :destroy
  end


  resources :products do
    get :who_bought, on: :member
  end

  scope '(:locale)' do
    get '/users/orders' => 'users#show_user_orders'
    get '/users/line_items' => 'users#show_user_line_items'
    resources :users
    resources :orders
    resources :line_items
    resources :carts
    root 'store#index', as: 'store_index', via: :all
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
