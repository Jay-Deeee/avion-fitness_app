require 'httparty'
require 'base64'

class MacrosController < ApplicationController
  before_action :authenticate_user!

  def index
    @logged_date = params[:logged_date].present? ? Date.parse(params[:logged_date]) : Date.current
    @macros = current_user.macros.where(logged_date: @logged_date, target: false)
    @target_macro = current_user.macros.find_by(logged_date: @logged_date, target: true)

    @totals = {
      calories: @macros.sum(:calories),
      protein: @macros.sum(:protein),
      carbohydrates: @macros.sum(:carbohydrates),
      fats: @macros.sum(:fats)
    }
  end

  def new
    @logged_date = params[:logged_date] ? Date.parse(params[:logged_date]) : Date.current
    @macro = current_user.macros.new(logged_date: @logged_date)
  end

  def create
    @macro = current_user.macros.new(macro_params)
    if @macro.save
      redirect_to macros_path(logged_date: @macro.logged_date), notice: "Target macros set!"
    else
      render :new
    end
  end

  def edit
    @macro = current_user.macros.find(params[:id])
  end

  def update
    @macro = current_user.macros.find(params[:id])
    if @macro.update(macro_params)
      redirect_to macros_path(logged_date: @macro.logged_date), notice: "Macro updated successfully!"
    else
      render :edit
    end
  end

  def show
    @logged_date = params[:logged_date] ? Date.parse(params[:logged_date]) : Date.current
    @meal_type = params[:meal]
    @logged_meals = current_user.macros
      .where(logged_date: @logged_date, meal: @meal_type, target: false)
    @results = [] # Initialized for fallback display
  end

  def search
    client = FatSecretApi.new
    @query = params[:query]
    @logged_date = params[:logged_date].present? ? Date.parse(params[:logged_date]) : Date.current
    @meal_type = params[:meal] || "breakfast"

    @logged_meals = current_user.macros
      .where(logged_date: @logged_date, meal: @meal_type, target: false)

    if @query.present?
      response = client.search_foods(@query)
      foods = response.dig("foods", "food")
      @results = foods.is_a?(Array) ? foods : [foods].compact
    else
      @results = []
    end
  end

  def log_meal
    @logged_date = (params[:logged_date] || params.dig(:macro, :logged_date))&.to_date || Date.current
    @meal_type = params[:meal] || params.dig(:macro, :meal)

    if params[:manual] == "true" || params[:food_id].blank?
      # Manual input
      macro_data = {
        name: params[:name],
        calories: params[:calories],
        protein: params[:protein],
        carbohydrates: params[:carbohydrates],
        fats: params[:fats],
        target: false,
        meal: @meal_type,
        logged_date: @logged_date
      }
    else
      # Via API
      client = FatSecretApi.new
      food = client.get_food(params[:food_id])["food"]
      serving = food["servings"]["serving"]
      serving = serving.is_a?(Array) ? serving.first : serving

      macro_data = {
        name: food["food_name"],
        calories: serving["calories"].to_f,
        protein: serving["protein"].to_f,
        carbohydrates: serving["carbohydrate"].to_f,
        fats: serving["fat"].to_f,
        target: false,
        meal: @meal_type,
        logged_date: @logged_date
      }
    end

    current_user.macros.create!(macro_data)

    redirect_back fallback_location: meal_view_macros_path(logged_date: @logged_date, meal: @meal_type), notice: "Meal logged!"
  end

  def add_meal
    @macros = current_user.macros.new(macro_params.merge(target: false))
    if @macros.save
      flash[:alert] = "Added Successfully!"
    else
      flash[:alert] = "Adding Unsuccessful."
    end
  end

  def destroy
    @macro = current_user.macros.find(params[:id])
    @macro.destroy
    redirect_to macros_path(logged_date: @macro.logged_date), notice: "Macro was successfully deleted."
  end

  private

  def macro_params
    params.require(:macro).permit(:name, :calories, :protein, :carbohydrates, :fats, :meal, :user_id, :logged_date)
  end
end
