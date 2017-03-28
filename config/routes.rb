Appointment::Application.routes.draw do
  root :to => "home#index"
  resources :sessions, only: :create
  get 'cities', to: 'cities#index'
  get 'districts', to: 'districts#index'

  require 'sidekiq/web'
  mount Sidekiq::Web => '/sidekiq'
  match 'sign_in' => 'sessions#new', as: :sign_in
  match 'sign_up' => 'sessions#destroy', as: :sign_up

  namespace :admin do
    get 'home', to: 'home#index'
    get 'staffs/download', to: 'staffs#download'
    get 'products/download', to: 'products#download'

    resources :system_records, :warehouse_products, :passwords
    resources :staff_transfers do 
      get :position, on: :collection
    end
    resources :staffs, :departments, :warehouses do
      put :normal, :disabled, on: :member
      get :import, :import_page, on: :collection
    end

    resources :warehouse_records do 
      get :pic, on: :collection
    end

    resources :products do 
      put :normal, :disabled, on: :member
      get :import, :import_page, :pic, on: :collection
    end

    resources :roles do
      put :normal, :disabled, on: :member
      get :edit_role, :list, on: :collection
      post :update_role, on: :collection
    end
  end

end
