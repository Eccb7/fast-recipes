class InventoriesController < ApplicationController
  before_action :authenticate_user!
  # before_action :set_inventory, only: [:show, :destroy]

  def index
    @inventories = current_user.inventories
    @inventory = Inventory.new
  end

  def create
    @inventory = current_user.inventories.build(inventory_params)
    if @inventory.save
      redirect_to inventories_path, notice: 'Inventory was successfully created.'
    else
      @inventories = current_user.inventories
      render :index
    end
  end

  def show
    @inventory = Inventory.find(params[:id])
    @inventory_food = @inventory.foods.build
  end

  def destroy
    @inventory = current_user.inventories.find(params[:id])
    @inventory.destroy
    redirect_to inventories_path, notice: 'Inventory was successfully deleted.'
  end

  private

  def inventory_params
    params.require(:inventory).permit(:name)
  end
end
