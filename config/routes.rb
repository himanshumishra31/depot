Rails.application.routes.draw do
  get 'admin' => 'admin#index'

  controller :sessions do
    get 'login' => :new
    post 'login' => :create
    delete 'logout' => :destroy
  end



  scope '(:locale)' do
    get '/users/orders', to: 'users#show_user_orders'
    get '/users/line_items', to: 'users#show_user_line_items'
    get '/categories/all', to: 'categories#show_categories'
    resources :users
    resources :orders
    resources :line_items
    resources :carts
    resources :categories
    resources :products
    root 'store#index', as: 'store_index', via: :all
  end

  resources :products do
    get :who_bought, on: :member
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
