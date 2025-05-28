class Calculator < ApplicationRecord
  belongs_to :user

def bmi_range
  return nil unless bmi

  case bmi
  when 0...18.5
    "Underweight"
  when 18.5...24.9
    "Normal weight"
  when 25...29.9
    "Overweight"
  else
    "Obese"
  end
end

def body_fat_range(gender)
  return nil unless body_fat

  case gender
  when "Male"
    case body_fat
    when 0...6
      "Essential fat (very low)"
    when 6...14
      "Athlete"
    when 14...18
      "Fit"
    when 18...25
      "Average"
    else
      "Obese"
    end
  when "Female"
    case body_fat
    when 0...14
      "Essential fat (very low)"
    when 14...21
      "Athlete"
    when 21...25
      "Fit"
    when 25...32
      "Average"
    else
      "Obese"
    end
  else
    "Unknown"
  end
end
end
