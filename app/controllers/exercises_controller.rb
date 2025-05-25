class ExercisesController < ApplicationController
  before_action :set_workout
  before_action :set_exercise, except: [:new, :create]

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
      render "workouts/index", status: :unprocessable_entity
    end
  end

  def edit; end

  def update
    if @exercise.update(comment_params)
      redirect_to request.referer || workouts_path, notice: "Comment has been updated."
    else
      flash[:alert] = "Failed to update exercise."
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @exercise.destroy
    redirect_to exercise_types_path, notice: "Exercise type was successfully deleted."
  end

  private

  def set_workout
    @workout = Workout.find(params[:workout_id])
  end

  def set_exercise
    @exercise = @workout.exercises.find(params[:id])
  end
  
  def exercise_params
    params.require(:exercise).permit(:exercise_type_id, :sets, :value, :weight)
  end
end
