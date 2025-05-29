Rails.application.routes.draw do
  get "pages/dashboard"
  get "up" => "rails/health#show", as: :rails_health_check
  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest

  root "pages#dashboard"

  devise_for :users

  resources :users do
    resource :calculator, only: [ :show ] do
      collection do
        post :calculate
        get :history, to: "calculators#index"
      end
    end
  end

  resources :workouts do
    resources :exercises, only: [ :new, :create, :destroy ] do
      member do
        patch :move_up
        patch :move_down
      end
      resources :exercise_sets, except: [ :index, :show ] do
        patch :move_up
        patch :move_down
      end
    end
  end

  resources :exercise_sets, only: [] do
    member do
      patch :toggle_completed
    end
  end

  resources :exercise_types, except: :show do
    collection do
      get :by_category
    end
  end

  patch "/users/:id/update_rest_time", to: "users#update_rest_time"

  resources :macros do
    collection do
      get :search
      post :log_meal
      post :add_meal
      get :meal_view, to: "macros#show"
    end

    member do
      get :edit
      patch :update
      delete :destroy
    end
  end
end
