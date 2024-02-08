class FoodsController < ApplicationController
  def new
    @food = Food.new
  end

  def create
    @food = Food.new(food_params)

    if @food.save
      redirect_to @food, notice: 'Food was successfully added.'
    else
      render :new
    end
  end

  def destroy_linked_with_inventory
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
    params.require(:food).permit(:name, :price, :measurement_unit, :inventory_id)
  end
end
