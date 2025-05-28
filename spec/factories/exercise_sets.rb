FactoryBot.define do
  factory :set do
    exercise { nil }
    value { 1 }
    weight { 1.5 }
    completed { false }
    position { 1 }
  end
end
