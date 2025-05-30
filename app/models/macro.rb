class Macro < ApplicationRecord
  belongs_to :user

  validates :calories, :protein, :carbohydrates, :fats,
    presence: { message: "must be provided" },
    numericality: { message: "must be a number", greater_than: 0 }

  validate :macros_must_be_greater_than_zero

  before_save :downcase_meal

  # Scope to get today's logged (non-target) macros
  # scope :today===, -> { where(created_at: Time.zone.today.all_day) }
  # scope :logged, -> { where(target: false) }
  scope :target_macros, -> { where(target: true) }
  scope :logged, -> { where(target: false) }

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

  def macros_must_be_greater_than_zero
    [:calories, :protein, :carbohydrates, :fats].each do |attr|
      value = send(attr)
      if value.present? && value.to_f <= 0
        errors.add(attr, "must be greater than zero")
      end
    end
  end

  def downcase_meal
    self.meal = meal&.downcase
  end
end
