Rails.application.routes.draw do
  get "pages/about"
  get "pages/services"
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/*
  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  get 'contact', to: 'pages#contact', as: :contact

  get "about", to: "pages#about", as: :about
  get "services", to: "pages#services", as: :services

  # Defines the root path route ("/")
  #root "posts#index"

  root "products#index"

  resources :users, only: [:show, :edit, :update]

  resources :products do
    resources :reservations, only: [:new, :create]
  end

  resources :reservations, only: [:index, :show, :edit, :update, :destroy]

  # Autres routes spécifiques ou personnalisées peuvent être ajoutées ici
end
