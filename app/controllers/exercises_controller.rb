class ExercisesController < ApplicationController
  before_action :set_workout
  before_action :set_exercise, except: [:new, :create]
  # rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

  def new
    @exercise = @workout.exercises.new
    @exercise_types = ExerciseType.all.order(:name)
  end

  def create
    @exercise = @workout.exercises.new(exercise_params)

    if @exercise.save
      redirect_to workouts_path(performed_on: @workout.performed_on), notice: "Exercise saved!"
    else
      flash.now[:alert] = "Failed to save task."
      render :new, status: :unprocessable_entity
    end
  end

  def edit; end

  def update
    if @exercise.update(exercise_params)
      redirect_to workout_path(@workout), notice: "Exercise has been updated."
    else
      flash[:alert] = "Failed to update exercise."
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @exercise.destroy
    redirect_to workouts_path(performed_on: @workout.performed_on), notice: "Exercise was successfully deleted."
  end

  private

  def set_workout
    @workout = current_user.workouts.find(params[:workout_id])
  end

  def set_exercise
    @exercise = @workout.exercises.find(params[:id])
  end
  
  def exercise_params
    params.require(:exercise).permit(:exercise_type_id, :sets, :value, :weight)
  end

  # def record_not_found
  #   redirect_to workouts_path, alert: "Record does not exist."
  # end
end
