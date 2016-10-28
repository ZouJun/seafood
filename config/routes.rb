Appointment::Application.routes.draw do

  root to: 'sessions#new'
  resources :sessions, only: :create
  match 'sign_in' => 'sessions#new', as: :sign_in
  match 'sign_up' => 'sessions#destroy', as: :sign_up

  namespace :admin do
    resources :bookings do
      get :auto, :cancel, on: :member
    end
    resources :menus, :passwords
    resources :agents do
      put :normal, :disabled, on: :member
    end
  end

  namespace :agent do
    resources :passwords
    resources :dispatchers do
      put :normal, :disabled, on: :member
    end
    resources :bookings do
      get :auto, :cancel, on: :member
    end
  end

  namespace :wap do
    resources :applies do
      collection do
        get :ordering
      end
    end
    resources :users, :searches
  end

end
