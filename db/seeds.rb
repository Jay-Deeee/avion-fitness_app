ExerciseType.create!([
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
  { name: "Shoulder Press", category: :back, unit: :reps },
  { name: "Lateral Flies", category: :back, unit: :reps },
  { name: "Facepulls", category: :back, unit: :reps },
  { name: "Pike Pushup", category: :back, unit: :reps },
  { name: "Rear Delt Machine Flies", category: :back, unit: :reps },

  # Biceps
  { name: "Bicep Curl", category: :back, unit: :reps },
  { name: "Hammer Curl", category: :back, unit: :reps },
  { name: "Preacher Curl", category: :back, unit: :reps },
  
  # Triceps
  { name: "Skullcrushers", category: :back, unit: :reps },
  { name: "Push Downs", category: :back, unit: :reps },
  { name: "Overhead Triceps Extension", category: :back, unit: :reps },
  
  # Forearms
  { name: "Deadhang", category: :back, unit: :seconds },
  { name: "Wrist Curl", category: :back, unit: :reps },
  { name: "Wrist Roller", category: :back, unit: :reps },
  
  # Legs
  { name: "Calf Raises", category: :legs, unit: :reps },
  { name: "Hack Squat", category: :legs, unit: :reps },
  { name: "Leg Curls", category: :legs, unit: :reps },
  { name: "Leg Extension", category: :legs, unit: :reps },
  { name: "Leg Press", category: :legs, unit: :reps },
  { name: "Squat", category: :legs, unit: :reps },

  # Core
  { name: "Crunches", category: :core, unit: :reps },
  { name: "Farmer Walk", category: :core, unit: :seconds },
  { name: "L-sit", category: :core, unit: :seconds },
  { name: "Leg Raises", category: :core, unit: :reps },
  { name: "Plank", category: :core, unit: :seconds },
  { name: "Seated Pike Lift", category: :core, unit: :reps },
  { name: "Side Plank", category: :core, unit: :seconds }
])
