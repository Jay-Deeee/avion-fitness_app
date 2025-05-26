class ExerciseSet < ApplicationRecord
  belongs_to :exercise

  validates :value, :position, presence: true
  validates :weight, numericality: true, allow_nil: true
  validates :completed, inclusion: { in: [true, false] }

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
end

# all this changes since making a separate set model. Please change accordingly.

# exercise = Exercise.new(value: 90)
# exercise.exercise_type = ExerciseType.new(unit: :seconds)

# exercise.display_value                    => "1m 30s"
# exercise.display_value(format: :short)    => "1:30"

# For a rep-based exercise
# exercise = Exercise.new(value: 12)
# exercise.exercise_type = ExerciseType.new(unit: :reps)

# exercise.display_value                    => "12 reps"
# 
#
# <p><strong>Sets:</strong> <%= exercise.sets %></p>
# <p><strong>Each Set:</strong> <%= exercise.display_value %></p>

