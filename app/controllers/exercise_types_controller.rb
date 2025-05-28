class ExerciseTypesController < ApplicationController
  # before_action :require_admin, only: [:edit, :update, :destroy]
  before_action :set_exercise_type, only: [:edit, :update, :destroy]

  def index
    @categories = ExerciseType.categories.keys
    @exercise_types = ExerciseType.order(:name).group_by(&:category)
  end

  def new
    @exercise_type = ExerciseType.new
  end

  def create
    @exercise_type = ExerciseType.new(exercise_type_params)

    if ExerciseType.exists?(["LOWER(name) = ?", @exercise_type.name.downcase])
      redirect_to request.referer || exercise_types_path, notice: "Exercise type '#{@exercise_type.name}' already exists."
    elsif @exercise_type.save
      redirect_to exercise_types_path, notice: "New exercise type created."
    else
      flash[:alert] = "Failed to create exercise type."
      render :new, status: :unprocessable_entity
    end
  end

  def edit; end

  def update
    if @exercise_type.update(exercise_type_params)
      redirect_to exercise_types_path, notice: "Exercise type has been updated."
    else
      flash[:alert] = "Failed to update exercise type."
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @exercise_type.destroy
    redirect_to exercise_types_path, notice: "Exercise type was successfully deleted."
  end

  def by_category
    @exercise_types = ExerciseType.where(category: params[:category]).order(:name)
    render json: @exercise_types.select(:id, :name)
  end

  private

  def set_exercise_type
    @exercise_type = ExerciseType.find(params[:id])
  end

  def exercise_type_params
    params.require(:exercise_type).permit(:name, :category, :unit)
  end

  # def require_admin
  #   unless current_user.admin?
  #     redirect_to root_path, alert: "You are not authorized to perform this action."
  #   end
  # end
end
