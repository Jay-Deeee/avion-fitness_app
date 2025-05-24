class ExerciseTypesController < ApplicationController
  # before_action :require_admin, only: [:destroy]
  def index
  end

  def show
  end

  def new
  end

  def create
    normalized_name = params[:exercise_type][:name].strip.titleize
    category = params[:exercise_type][:category]

    existing = ExerciseType.find_by("LOWER(name) = ?", normalized_name.downcase)

    if existing
      redirect_to request.referer || root_path, notice: "Exercise type '#{existing.name}' already exists. Using the existing one."
    else
      @exercise_type = ExerciseType.new(name: normalized_name, category: category)

      if @exercise_type.save
        redirect_to request.referer || root_path, notice: "New exercise type created."
      else
        flash[:alert] = "Failed to create exercise type."
        redirect_to request.referer || root_path, status: :unprocessable_entity
      end
    end
  end

  def edit
  end

  def update
  end

  def destroy
    @exercise_type = ExerciseType.find(params[:id])
    @exercise_type.destroy
    redirect_to exercise_types_path, notice: "Exercise type was successfully deleted."
  end

  def by_category
    category = params[:category]
    @exercise_types = ExerciseType.where(category: category)
    render json: @exercise_types.select(:id, :name)
  end  

  private

  # def require_admin
  #   unless current_user.admin?
  #     redirect_to root_path, alert: "You are not authorized to perform this action."
  #   end
  # end
end
