
  [
  # Chest
  { name: "Bench Press", category: :chest, unit: :reps },
  { name: "Butterflies", category: :chest, unit: :reps },
  { name: "Decline Bench Press", category: :chest, unit: :reps },
  { name: "Incline Bench Press", category: :chest, unit: :reps },
  { name: "Chest Dips", category: :chest, unit: :reps },
  { name: "Pushups", category: :chest, unit: :reps },
  { name: "Seated Machine Flies", category: :chest, unit: :reps },

  # Back
  { name: "Chin Up", category: :back, unit: :reps },
  { name: "Deadlift", category: :back, unit: :reps },
  { name: "Dumbbell Row", category: :back, unit: :reps },
  { name: "Good Morning", category: :back, unit: :reps },
  { name: "Lat Pulldown", category: :back, unit: :reps },
  { name: "Pull Up", category: :back, unit: :reps },
  { name: "Scapular Shrug", category: :back, unit: :reps },
  { name: "Shrug", category: :back, unit: :reps },

  # Shoulders
  { name: "Shoulder Press", category: :shoulder, unit: :reps },
  { name: "Lateral Flies", category: :shoulder, unit: :reps },
  { name: "Facepulls", category: :shoulder, unit: :reps },
  { name: "Pike Pushup", category: :shoulder, unit: :reps },
  { name: "Rear Delt Machine Flies", category: :shoulder, unit: :reps },

  # Biceps
  { name: "Bicep Curl", category: :bicep, unit: :reps },
  { name: "Hammer Curl", category: :bicep, unit: :reps },
  { name: "Preacher Curl", category: :bicep, unit: :reps },
  
  # Triceps
  { name: "Skullcrushers", category: :tricep, unit: :reps },
  { name: "Push Downs", category: :tricep, unit: :reps },
  { name: "Overhead Triceps Extension", category: :tricep, unit: :reps },
  
  # Forearms
  { name: "Deadhang", category: :forearm, unit: :seconds },
  { name: "Wrist Curl", category: :forearm, unit: :reps },
  { name: "Wrist Roller", category: :forearm, unit: :reps },
  
  # leg
  { name: "Calf Raises", category: :leg, unit: :reps },
  { name: "Hack Squat", category: :leg, unit: :reps },
  { name: "Leg Curls", category: :leg, unit: :reps },
  { name: "Leg Extension", category: :leg, unit: :reps },
  { name: "Leg Press", category: :leg, unit: :reps },
  { name: "Squat", category: :leg, unit: :reps },

  # Core
  { name: "Crunches", category: :core, unit: :reps },
  { name: "Farmer Walk", category: :core, unit: :seconds },
  { name: "L-sit", category: :core, unit: :seconds },
  { name: "Leg Raises", category: :core, unit: :reps },
  { name: "Plank", category: :core, unit: :seconds },
  { name: "Seated Pike Lift", category: :core, unit: :reps },
  { name: "Side Plank", category: :core, unit: :seconds }
].each do |exercise|
  ExerciseType.find_or_create_by!(name: exercise[:name]) do |e|
    e.category = exercise[:category]
    e.unit = exercise[:unit]
  end
end

# Seed Quotes
[
"Your excuses burn zero calories — try again.",
"Some people want a hot body. Others actually work for it. Be the latter.",
"You can’t complain about the results you didn’t get from the work you didn’t do.",
"If you’re waiting for motivation, stay on the couch. The gym is for doers.",
"That six-pack won’t build itself — unfortunately, neither will your discipline.",
"You said 'tomorrow' yesterday.",
"Stop calling it your ‘winter body’ — it’s been winter for 4 years now.",
"Your body isn't Amazon Prime. Results won’t show up in two days.",
"Sweat is your fat crying. Let it sob uncontrollably.",
"Skipping leg day? Bold move for someone who wants to walk tomorrow.",
"Keep lifting… your standards too.",
"Your workout is your therapist, but cheaper and doesn’t listen to whining.",
"You can’t Photoshop your body in real life. Hit the gym.",
"Train like your ex is watching.",
"You can rest when you're hot. Right now, you're just sweaty."
].each do |text|
  Quote.find_or_create_by!(quote: text)
end