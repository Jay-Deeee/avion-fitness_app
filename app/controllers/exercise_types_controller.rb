class ExerciseTypesController < ApplicationController
  # before_action :require_admin, only: [:destroy]
  def index
  end

  def show
  end

  def new
  end

  def create
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

  private

  # def require_admin
  #   unless current_user.admin?
  #     redirect_to root_path, alert: "You are not authorized to perform this action."
  #   end
  # end
end
