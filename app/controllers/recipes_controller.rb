class RecipesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_recipe, only: %i[show destroy toggle_public]

  def index
    @recipes = current_user.recipes
    @public_recipes = Recipe.where(public: true).order(created_at: :desc)
  end

  def show
    @recipe = Recipe.includes(:recipe_foods).find(params[:id])
    @recipe_foods = @recipe.recipe_foods
    @food = Food.new
  end

  def new
    @recipe = Recipe.new
  end

  def create
    @recipe = current_user.recipes.build(recipe_params)
    if @recipe.save
      redirect_to @recipe, notice: 'Recipe was successfully created.'
    else
      render :new
    end
  end

  def destroy
    @recipe = Recipe.find(params[:id])
    @recipe.destroy

    redirect_to recipes_path, notice: 'Recipe was successfully destroyed.'
  end

  def toggle_public
    @recipe.toggle!(:public)
    redirect_to @recipe, notice: 'Recipe privacy status updated.'
  end

  def public_recipes
    @public_recipes = Recipe.where(public: true)

    respond_to do |format|
      format.html { render 'public_recipes' } # Add this line if you want an HTML response
      # format.json { render json: @public_recipes } # Add this line for JSON response
    end
  end

  def total_food_items
    recipe_foods.joins(food: :inventory_foods).count
  end

  def total_price
    recipe_foods.joins(food: :inventory_foods).sum('quantity * foods.price')
  end

  private

  def set_recipe
    @recipe = Recipe.find(params[:id])
    @recipe.load_recipe_foods
    redirect_to recipes_path, alert: 'Access denied.' unless current_user_owns_recipe?(@recipe)
  end

  def current_user_owns_recipe?(recipe)
    recipe.user == current_user
  end

  def recipe_params
    params.require(:recipe).permit(:recipe_name, :preparation_time, :cooking_time, :description, :public)
  end
  helper_method :current_user_owns_recipe?
end
