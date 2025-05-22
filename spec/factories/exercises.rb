FactoryBot.define do
  factory :exercise do
    workout { nil }
    exercise_type { nil }
    sets { 1 }
    value { 1 }
    weight { 1.5 }
  end
end
