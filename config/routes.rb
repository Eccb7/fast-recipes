Rails.application.routes.draw do
  get 'foods/create'
  get 'foods/destroy'
  get 'inventories/index'
  get 'inventories/show'
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  root "rails/health#show"

  resources :inventories 
  resources :foods do
    post 'create_food_linked_with_inventory', on: :collection
  end
  # This route assumes that the action is not nested under inventories resources
  delete 'inventories/:inventory_id/foods/:id/destroy_food_linked_with_inventory', to: 'foods#destroy_food_linked_with_inventory', as: 'destroy_food_linked_with_inventory'

end
