class PagesController < ApplicationController
  def dashboard
    seed = Date.today.to_s
    @quote = Quote.offset(Random.new(seed.hash).rand(Quote.count)).first
    # @macronutrients = Macronutrient.order(food_type: :asc,food: :asc);
    @grouped_data = Macronutrient.all.group_by(&:food_type)
  end
end
