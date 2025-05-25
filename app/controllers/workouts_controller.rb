class WorkoutsController < ApplicationController
  before_action :set_workout, only: [:show, :edit, :update, :destroy]
  # rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
  
  def index
    if params[:performed_on].present?
      @selected_date = Date.parse(params[:performed_on]) rescue nil
      @workout = current_user.workouts.find_by(performed_on: @selected_date)
    else
      @workouts = current_user.workouts.order(performed_on: :desc)
    end
  end

  def show
    @exercises = @workout.exercises
  end

  def new
    @workout = Workout.new
  end

  def create
    @workout = current_user.workouts.new(workout_params)

    if @workout.save
      redirect_to request.referer || workouts_path, notice: "Workout for: '#{@workout.performed_on.strftime("%b %d, %Y")}' saved successfully."
    else
      flash[:alert] = "Failed to save workout."
      render :new, status: :unprocessable_entity
    end
  end

  def edit; end

  def update
    if @workout.update(workout_params)
      redirect_to @workout, notice: "Workout has been updated."
    else
      flash[:alert] = "Failed to update workout."
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @workout.destroy
    redirect_to workouts_path, status: :see_other, notice: "Workout has been deleted."
  end

  private

  def set_workout
    @workout = current_user.workouts.find(params[:id])
  end

  def workout_params
    params.require(:workout).permit(:name, :performed_on)
  end

  # def record_not_found
  #   redirect_to workouts_path, alert: "Record does not exist."
  # end
end
