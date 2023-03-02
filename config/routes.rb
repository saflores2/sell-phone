Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  # Defines the root path route ("/")
  # root "articles#index"
  resources :products do
    resources :registers, only: [:create]
    collection do
      get :my_products
    end
  end

  resources :registers, only: [:update] do
    member do
      get :response
      get :payment
      get :confirmation
      patch :accept
      patch :reject
    end

    collection do
      get :my_registers
    end
  end
end
