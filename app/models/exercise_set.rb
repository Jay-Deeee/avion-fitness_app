class ExerciseSet < ApplicationRecord
  belongs_to :exercise

  validates :value, :position, presence: true
  validates :weight, numericality: true, allow_nil: true
  validates :completed, inclusion: { in: [true, false] }

  default_scope { order(position: :asc) }

  before_create :set_default_position

  def unit
    exercise.exercise_type.unit
  end

  def display_value(format: :long)
    return "#{value} reps" if unit == "reps"

    minutes = value / 60
    seconds = value % 60

    case format
    when :long
      parts = []
      parts << "#{minutes}m" if minutes > 0
      parts << "#{seconds}s" if seconds > 0
      parts.join(" ")
    when :short
      format("%d:%02d", minutes, seconds)
    else
      "#{value} seconds"
    end
  end

  def move_up
    swap_with(exercise_set_above)
  end

  def move_down
    swap_with(exercise_set_below)
  end

  private

  def set_default_position
    self.position ||= (exercise.exercise_sets.maximum(:position) || -1) + 1
  end

  def exercise_set_above
    exercise.exercise_sets.where("position < ?", position).reorder(position: :desc).first
  end

  def exercise_set_below
    exercise.exercise_sets.where("position > ?", position).reorder(position: :asc).first
  end

  def swap_with(other)
    return unless other

    ExerciseSet.transaction do
      self_position = self.position
      self.update!(position: other.position)
      other.update!(position: self_position)
    end
  end
end
