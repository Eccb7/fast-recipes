Rails.application.routes.draw do
  devise_for :users

  get "up" => "rails/health#show", as: :rails_health_check

  root "recipes#public_recipes"

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
    resources :recipe_foods, only: [:new, :create, :destroy]
  end

  get 'public_recipes', to: 'recipes#public_recipes', as: :public_recipes

  resources :public_recipes, only: :index, controller: 'recipes'

  resources :users, only: [:index, :show, :edit, :update, :destroy]
end
