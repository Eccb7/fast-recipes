class FoodsController < ApplicationController
  def create; end

  def create_food_linked_with_inventory
    @inventory = Inventory.find(params[:inventory_id])
    @food = Food.new
    @food.name = food_params[:name]
    @food.measurement_unit = food_params[:measurement_unit]
    @food.price = food_params[:price]
    if @food.save
      @inventory.foods << @food
      redirect_to @inventory, notice: 'Food was successfully added.'
    else
      render 'inventories/show'
    end
  end

  def destroy_food_linked_with_inventory
    inventory = Inventory.find(params[:inventory_id])
    food = Food.find(params[:id])
    inventory.foods.delete(food)
    food.destroy

    if inventory.save
      flash[:notice] = 'Food item was successfully removed from the inventory.'
    else
      flash[:alert] = 'Failed to remove the food item from the inventory.'
    end

    redirect_to inventory, notice: 'Food was successfully removed.'
  end

  private

  def food_params
    params.permit(:name, :price, :measurement_unit, :inventory_id)
  end
end
