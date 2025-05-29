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
    # current_user.macros.where(target: true).destroy_all
    @macro = current_user.macros.new(macro_params)
    if @macro.save
      redirect_to macros_path(logged_date: @macro.logged_date.to_date), notice: "Target macros set!"
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
      redirect_to macros_path(logged_date: @macro.logged_date.to_date), notice: "Macro updated successfully!"
    else
      render :edit
    end
  end

  def show
    @selected_date = params[:date].present? ? Date.parse(params[:date]) : Date.current
    @logged_date = params[:logged_date] ? Date.parse(params[:logged_date]) : Date.current
    @meal_type = params[:meal]

    @logged_meals = current_user.macros
      .where(logged_date: @logged_date, meal: @meal_type, target: false)

    @results = [] # Optionally initialize for search fallback
  end

  def search
    @user_id = params[:user_id]
    @selected_date = params[:date].present? ? Date.parse(params[:date]) : Date.current
    @meal_type = params[:meal] || 'breakfast'
    @logged_date = params[:logged_date] ? Date.parse(params[:logged_date]) : Date.current

    # Fetch already-logged food for the selected meal and date
    @logged_meals = current_user.macros
                                .where(created_at: @selected_date.all_day, meal: @meal_type, target: false)

    # Authenticate with FatSecret
    auth_response = HTTParty.post("https://oauth.fatsecret.com/connect/token",
      body: {
        grant_type: "client_credentials",
        scope: "basic"
      },
      headers: {
        "Authorization" => "Basic #{Base64.strict_encode64("#{ENV['FATSECRET_CLIENT_ID']}:#{ENV['FATSECRET_CLIENT_SECRET']}")}",
        "Content-Type" => "application/x-www-form-urlencoded"
      }
    )
    if auth_response.code != 200
      flash[:alert] = "Error authenticating with FatSecret API."
      return render :search
    end

    token = auth_response["access_token"]

    @results = []
    if params[:query].present?
      search_response = HTTParty.get("https://platform.fatsecret.com/rest/server.api", {
        query: {
          method: "foods.search",
          format: "json",
          search_expression: params[:query]
        },
        headers: {
          "Authorization" => "Bearer #{token}"
        }
      })

      @results = search_response.parsed_response.dig("foods", "food") || []
      # @description = search_response.parsed_response.dig("foods", "food", "food_description") || []
      # @calories = @description[/Calories:\s([\d.]+)kcal/, 1].to_f
      # @protein = @description[/Protein:\s([\d.]+)g/, 1].to_f
      # @carbohydrates = @description[/Carbs:\s([\d.]+)g/, 1].to_f
      # @fats = @description[/Fat:\s([\d.]+)g/, 1].to_f
    end
  end

  def log_meal
    @meal_type = params[:meal] || params.dig(:macro, :meal)
    @user_id = params[:user_id] || current_user.id
    @logged_date = (params[:logged_date] || params.dig(:macro, :logged_date))&.to_date || Date.current


    if params[:food_id].present?
      # Logging via FatSecret
      response = HTTParty.get("https://platform.fatsecret.com/rest/server.api", {
        query: {
          method: "food.get",
          food_id: params[:food_id],
          format: "json"
        },
        headers: {
          "Authorization" => "Bearer #{ENV['FATSECRET_ACCESS_TOKEN']}"
        }
      })

      food = JSON.parse(response.body)["food"]
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
    else
      # Manual log
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
    end

    current_user.macros.create!(macro_data)

    redirect_back fallback_location: meal_view_macros_path(logged_date: @logged_date, meal: @meal_type, user_id: @user_id), notice: "Meal logged!"
  end


  def add_meal
    # @macros = Macro.new(macro_params)
    # @macros.user_id = current_user.id
    @macros = current_user.macros.new(macro_params.merge(target: false))
    if @macros.save
      flash[:alert] = "Added Successfully!"
    else
      flash[:alert] = "Adding Unsucessfull."
    end
  end

  def destroy
    @macro = current_user.macros.find(params[:id])
    @macro.destroy
    redirect_to macros_path, notice: "Macro was successfully deleted."
  end

  private

  def macro_params
    params.require(:macro).permit(:name, :calories, :protein, :carbohydrates, :fats, :meal, :user_id, :logged_date)
  end
end
