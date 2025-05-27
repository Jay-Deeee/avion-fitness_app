class ExerciseSetsController < ApplicationController
  before_action :set_workout, :set_exercise, except: [:toggle_completed]
  before_action :set_exercise_set, only: [:edit, :update, :destroy]
  # rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

  def new
    @exercise_set = @exercise.exercise_sets.new
  end

  def create
    last_position = @exercise.exercise_sets.maximum(:position) || 0
    @exercise_set = @exercise.exercise_sets.new(exercise_set_params.merge(position: last_position + 1))

    if @exercise_set.save
      redirect_to workout_path(@exercise.workout), notice: "Set added!"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit; end

  def update
    if @exercise_set.update(exercise_set_params)
      redirect_to workout_path(@exercise.workout), notice: "Set updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @exercise_set.destroy
    redirect_to workout_path(@exercise.workout), notice: "Set removed."
  end

  def toggle_completed
    @exercise_set = ExerciseSet.find(params[:id])
    if @exercise_set.update(completed: !@exercise_set.completed)
      render json: { completed: @exercise_set.completed }
    else
      render json: { error: "Unable to update set" }, status: :unprocessable_entity
    end
  end

  def move_up
    @exercise_set = @exercise.exercise_sets.find(params[:exercise_set_id])
    @exercise_set.move_up
    redirect_back fallback_location: workout_path(@exercise.workout)
  end
  
  def move_down
    @exercise_set = @exercise.exercise_sets.find(params[:exercise_set_id])
    @exercise_set.move_down
    redirect_back fallback_location: workout_path(@exercise.workout)
  end

  private

  def set_workout
    @workout = current_user.workouts.find(params[:workout_id])
  end

  def set_exercise
    @exercise = @workout.exercises.find(params[:exercise_id])
  end

  def set_exercise_set
    @exercise_set = @exercise.exercise_sets.find(params[:id])
  end

  def exercise_set_params
    params.require(:exercise_set).permit(:value, :weight)
  end

  # def record_not_found
  #   redirect_to workouts_path, alert: "Record does not exist."
  # end
end
