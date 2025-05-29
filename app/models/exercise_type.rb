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
