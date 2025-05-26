class ExerciseSetsController < ApplicationController
  before_action :set_workout, :set_exercise
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

  private

  def set_workout
    @workout = Workout.find(params[:workout_id])
  end

  def set_exercise
    @exercise = Exercise.find(params[:exercise_id])
  end

  def set_exercise_set
    @exercise_set = @exercise.exercise_sets.find(params[:id])
  end

  def exercise_set_params
    params.require(:exercise_set).permit(:value, :weight, :completed, :position)
  end

  # def record_not_found
  #   redirect_to workouts_path, alert: "Record does not exist."
  # end
end
