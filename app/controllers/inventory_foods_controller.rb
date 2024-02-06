class InventoryFoodsController < ApplicationController
  def create
    @inventory = Inventory.find(params[:inventory_id])
    @inventory_food = @inventory.inventory_foods.build(inventory_food_params)
    if @inventory_food.save
      redirect_to @inventory, notice: 'Food item was successfully added.'
    else
      render 'inventories/show'
    end
  end

  private

  def inventory_food_params
    params.require(:inventory_food).permit(:food_id, :quantity)
  end
end
