class Macro < ApplicationRecord
  belongs_to :user

  validates :calories, :protein, :carbohydrates, :fats, presence: true
  validates :calories, numericality: { greater_than_or_equal_to: 0 }
  validates :protein, :carbohydrates, :fats, numericality: true

  before_save :downcase_meal

  # Scope to get today's logged (non-target) macros
  # scope :today===, -> { where(created_at: Time.zone.today.all_day) }
  # scope :logged, -> { where(target: false) }
  scope :target, -> { where(target: true) }

  # Optional: total macros calculation for a given user
  def self.totals
    {
      calories: sum(:calories),
      protein: sum(:protein),
      carbohydrates: sum(:carbohydrates),
      fats: sum(:fats)
    }
  end

  private
  
  def downcase_meal
    self.meal = meal.downcase if meal.present?
  end
end
