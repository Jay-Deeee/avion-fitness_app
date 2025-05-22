class ExerciseType < ApplicationRecord
  has_many :exercises, dependent: :nullify
  before_save :normalize_name

  validates :name, presence: true, uniqueness: { case_sensitive: false }
  validates :category, :unit, presence: true

  enum category: {
    chest: 0,
    back: 1,
    shoulder: 2,
    bicep: 3,
    tricep: 4,
    forearm: 5,
    leg: 6,
    core: 7
  }, _prefix: true

  enum unit: {
    reps: 0, 
    seconds: 1
  }, _prefix: true

  private

  def normalize_name
    self.name = name.strip.titleize
  end
end

# Exercise.create!(
#   workout_id: 1,
#   exercise_type_id: 1,
#   sets: 4,
#   value: 8,
#   unit: :reps
# ) 
#
# ExerciseType.category_biceps
# 
# exercise_type.category_chest?
# exercise_type.category_core? 
# 
# <%= form.select :category, ExerciseType.categories.keys.map { |c| [c.titleize, c] } %>
