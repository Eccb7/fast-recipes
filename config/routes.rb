Rails.application.routes.draw do
  devise_for :users

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  root "rails/health#show"

  resources :inventories, only: [:index, :show] do
    resources :inventory_foods, only: [:create, :destroy]
  end

  resources :foods, only: [:create, :destroy] do
    post 'create_food_linked_with_inventory', on: :collection
    delete 'destroy_food_linked_with_inventory/:inventory_id', to: 'foods#destroy_food_linked_with_inventory', as: 'destroy_food_linked_with_inventory'
  end

  resources :recipes do
    member do
      post 'toggle_public'
    end
    resources :recipe_foods
  end

  get 'public_recipes', to: 'recipes#public_recipes', as: :public_recipes

  resources :public_recipes, only: :index, controller: 'recipes'

  resources :users, only: [:index, :show, :edit, :update, :destroy]
end
