Appointment::Application.routes.draw do

  resources :sessions, only: :create
  match 'sign_in' => 'sessions#new', as: :sign_in
  match 'sign_up' => 'sessions#destroy', as: :sign_up
  namespace :admin do
    resources :bookings, :agents, :menus
  end

  namespace :agent do
    resources :bookings
  end

  namespace :wap do
    resources :applies do
      collection do
        get :ordering
      end
    end
  end

end
