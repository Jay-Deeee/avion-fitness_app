Rails.application.routes.draw do
  get "pages/dashboard"
  get "up" => "rails/health#show", as: :rails_health_check
  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest

  root "pages#dashboard"

  devise_for :users
  get "calculator", to: "calculators#show", as: :calculator
  post "calculator/calculate", to: "calculators#calculate", as: :calculator_calculate
  get "calculator/history", to: "calculators#index", as: :calculator_history

  resources :workouts do
    resources :exercises, except: [ :index, :show ]
  end

  resources :exercise_types, except: :show do
    collection do
      get :by_category
    end
  end

  resources :macros, only: [:index, :new, :create, :edit, :update, :destroy] do
    collection do
      get :search
      post :log
    end
    member do
      get :edit
      patch :update
      delete :destroy
    end
  end
end