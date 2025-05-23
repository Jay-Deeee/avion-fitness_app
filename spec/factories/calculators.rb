FactoryBot.define do
  factory :calculator do
    weight { 1.5 }
    height { 1.5 }
    waist_line { 1.5 }
    neck_line { 1.5 }
    date { "2025-05-23" }
    bmi { 1.5 }
    body_fat { 1.5 }
    user { nil }
  end
end
