class ExercisesController < ApplicationController
  def new
  end

  def create
    normalized_name = params[:name].strip.titleize
    existing = ExerciseType.find_by("LOWER(name) = ?", normalized_name.downcase)

    if existing
      @exercise_type = existing
    else
      @exercise_type = ExerciseType.create(name: normalized_name, category: params[:category])
    end
  end

  def edit
  end

  def update
  end

  def destroy
  end
end
