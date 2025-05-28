require 'httparty'
require 'base64'

class MacrosController < ApplicationController
  before_action :authenticate_user!

  def index
    selected_date = params[:date].present? ? Date.parse(params[:date]) : Date.current
    @macros = current_user.macros.where(created_at: selected_date.all_day, target: false)
    @target_macro = current_user.macros.find_by(created_at: selected_date.all_day, target: true)

    @totals = {
      calories: @macros.sum(:calories),
      protein: @macros.sum(:protein),
      carbohydrates: @macros.sum(:carbohydrates),
      fats: @macros.sum(:fats)
    }
  end

  def new
    @macro = Macro.new
  end

  def create
    current_user.macros.where(target: true).destroy_all

    @macro = current_user.macros.new(macro_params.merge(target: true))
    if @macro.save
      redirect_to macros_path, notice: "Target macros set!"
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
      redirect_to macros_path(date: @macro.created_at.to_date), notice: "Macro updated successfully!"
    else
      render :edit
    end
  end

  def show
    @selected_date = params[:date].present? ? Date.parse(params[:date]) : Date.current
    @meal_type = params[:meal]

    @logged_meals = current_user.macros
      .where(created_at: @selected_date.all_day, meal: @meal_type, target: false)

    @results = [] # Optionally initialize for search fallback
  end

  # def meal
  #   @selected_date = Date.parse(params[:date])
  #   @meal_type = params[:meal]

  #   @logged_meals = current_user.macros
  #     .where(created_at: @selected_date.all_day, meal: @meal_type, target: false)

  #   @results = NutritionixApi.search(params[:query]) if params[:query].present?
  # end

  def search
    @selected_date = params[:date].present? ? Date.parse(params[:date]) : Date.current
    @meal_type = params[:meal] || 'breakfast'

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
    end
  end

  def log
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
        meal: params[:meal],
        created_at: Date.parse(params[:date]) || Date.current
        }
      else
   # Manual meal log (form)
      macro_data = {
        name: params[:name],
        calories: params[:calories],
        protein: params[:protein],
        carbohydrates: params[:carbohydrates],
        fats: params[:fats],
        target: false,
        meal: params[:meal],
        created_at: Date.parse(params[:date]) || Date.current
        }
      end
    current_user.macros.create!(macro_data)
    redirect_to search_macros_path(meal: macro_data[:meal], date: params[:date]), notice: "Meal logged!"
  end

  def add_macros
    # @macros = Macro.new(macro_params)
    # @macros.user_id = current_user.id
    @macros = current_user.macros.new(macro_params)
    if @macros.save
      flash[:alert] = "Added Successfully!"
    else 
      flash[:alert] = "Adding Unsucessfull."
    end
  end
  private

  def macro_params
    params.require(:macro).permit(:name, :calories, :protein, :carbohydrates, :fats, :meal, :user_id)
  end
end
