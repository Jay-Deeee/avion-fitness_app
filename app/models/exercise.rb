class Exercise < ApplicationRecord
  belongs_to :workout
  belongs_to :exercise_type
  has_many :exercise_sets, dependent: :destroy
  # accepts_nested_attributes_for :exercise_sets, allow_destroy: true
end
