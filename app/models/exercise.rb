class Exercise < ApplicationRecord
  belongs_to :workout
  belongs_to :exercise_type
  has_many :exercise_sets, dependent: :destroy
  
  default_scope { order(position: :asc) }

  before_create :set_default_position

  def move_up
    swap_with(exercise_above)
  end

  def move_down
    swap_with(exercise_below)
  end

  private

  def set_default_position
    self.position ||= (workout.exercises.maximum(:position) || -1) + 1
  end

  def exercise_above
    workout.exercises.where("position < ?", position).order(position: :desc).first
  end

  def exercise_below
    workout.exercises.where("position > ?", position).order(position: :asc).first
  end

  def swap_with(other)
    return unless other

    Exercise.transaction do
      self_position = self.position
      self.update!(position: other.position)
      other.update!(position: self_position)
    end
  end
end
