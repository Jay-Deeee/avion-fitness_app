
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



[
  # Fruit
  { food: "Apple", serving_size: "1 (4 oz.)", protein: "0.27g" ,carbs: "14.36g",fat: "0.18g",food_type:"Fruit" },
  { food: "Banana", serving_size: "	1 (6 oz.)", protein: "1.85g" ,carbs: "38.85g	",fat: "0.56g",food_type:"Fruit" },
  { food: "Grapes", serving_size: "	1 cup", protein: "	1.15g" ,carbs: "28.96g",fat: "0.26g",food_type:"Fruit" },
  { food: "Orange", serving_size: "1 (4 oz.)", protein: "0.79g" ,carbs: "11.79g",fat: "0.23g",food_type:"Fruit" },
  { food: "Pear", serving_size: "	1 (5 oz.)", protein: "0.54g" ,carbs: "21.91g",fat: "0.17g",food_type:"Fruit" },
  { food: "Peach", serving_size: "1 (6 oz.)", protein: "1.2g" ,carbs: "	12.59g",fat: "0.33g",food_type:"Fruit" },
  { food: "Pineapple", serving_size: "	1 cup", protein: "0.84g" ,carbs: "19.58g",fat: "0.19g",food_type:"Fruit" },
  { food: "Strawberry", serving_size: "1 cup", protein: "	1.11g" ,carbs: "12.75g",fat: "0.5g",food_type:"Fruit" },
  { food: "Watermelon", serving_size: "1 cup", protein: "	0.93g" ,carbs: "	11.48g",fat: "0.23g",food_type:"Fruit" },

    # Vegetables
  { food: "Asparagus", serving_size: "1 cup", protein: "	2.95g" ,carbs: "5.2g",fat: "	0.16g",food_type:"Vegetables" },
  { food: "Broccoli", serving_size: "	1 cup", protein: "	2.57g" ,carbs: "6.04g	",fat: "0.34g",food_type:"Vegetables" },
  { food: "Carrots", serving_size: "	1 cup", protein: "1.19g" ,carbs: "12.26g	",fat: "0.31g",food_type:"Vegetables" },
  { food: "Cucumber", serving_size: "4 oz.", protein: "0.67g" ,carbs: "2.45g",fat: "	0.18g",food_type:"Vegetables" },
  { food: "Eggplant", serving_size: "1 cup", protein: "0.98g" ,carbs: "5.88g",fat: "	0.18g",food_type:"Vegetables" },
  { food: "Lettuce", serving_size: "1 cup", protein: "0.5g" ,carbs: "1.63g",fat: "0.08g",food_type:"Vegetables" },
  { food: "Tomato", serving_size: "1 cup", protein: "1.58g" ,carbs: "17.06g",fat: "0.36g",food_type:"Vegetables" },

    # Proteins
  { food: "Beef, regular, cooked", serving_size: "2 oz.", protein: "	0g" ,carbs: "5.2g",fat: "	010.4g",food_type:"Proteins" },
  { food: "Chicken, cooked", serving_size: "2 oz.", protein: "0g	" ,carbs: "6.04g	",fat: "1.84g",food_type:"Proteins" },
  { food: "Tofu", serving_size: "4 oz.", protein: "7.82g" ,carbs: "2.72g	",fat: "3.06g",food_type:"Proteins" },
  { food: "Egg", serving_size: "	2 oz.", protein: "6.29g" ,carbs: "0.38g",fat: "	4.97g",food_type:"Proteins" },
  { food: "Fish, Catfish, cooked", serving_size: "9.96g", protein: "4.84g" ,carbs: "8.24g",fat: "	0.18g",food_type:"Proteins" },
  { food: "Pork, cooked", serving_size: "	2 oz.", protein: "	15.82g" ,carbs: "0g",fat: "8.26g",food_type:"Proteins" },
  { food: "Shrimp, cooked", serving_size: "	2 oz.", protein: "15.45g" ,carbs: "0.69g",fat: "1.32g",food_type:"Proteins" },

  # Common Meals/Snacks
  { food: "Bread, white", serving_size: "1 slice (1 oz.)", protein: "	1.91g" ,carbs: "12.65g",fat: "0.82g",food_type:"Common Meals/Snacks" },
  { food: "Butter", serving_size: "1 tablespoon", protein: "0.12g" ,carbs: "0.01g",fat: "	11.52g",food_type:"Common Meals/Snacks" },
  { food: "Caesar salad", serving_size: "3 cups", protein: "16.3g" ,carbs: "21.12g",fat: "45.91g",food_type:"Common Meals/Snacks" },
  { food: "Cheeseburger", serving_size: "1 sandwich", protein: "14.77g" ,carbs: "	31.75g",fat: "	15.15g",food_type:"Common Meals/Snacks" },
  { food: "Hamburger", serving_size: "1 sandwich", protein: "14.61g" ,carbs: "26.81g",fat: "	10.97g",food_type:"Common Meals/Snacks" },
  { food: "Dark Chocolate", serving_size: "	1 oz.", protein: "1.57g" ,carbs: "16.84g",fat: "9.19g",food_type:"Common Meals/Snacks" },
  { food: "Corn", serving_size: "1 cup", protein: "4.3g" ,carbs: "30.49g	",fat: "1.64g",food_type:"Common Meals/Snacks" },
  { food: "Pizza", serving_size: "1 slice (14')", protein: "13.32g" ,carbs: "33.98g",fat: "	12.13g",food_type:"Common Meals/Snacks" },
  { food: "Potato", serving_size: "6 oz.", protein: "4.47g" ,carbs: "36.47g",fat: "0.22g",food_type:"Common Meals/Snacks" },
  { food: "Rice", serving_size: "1 cup cooked", protein: "4.2g" ,carbs: "	44.08g",fat: "0.44g",food_type:"Common Meals/Snacks" },
  { food: "Sandwich", serving_size: "1 (6' Subway Turkey Sandwich)", protein: "18g" ,carbs: "46g",fat: "3.5g",food_type:"Common Meals/Snacks" }
 
  
 
].each do |macrofood|
  Macronutrient.find_or_create_by!(food: macrofood[:food]) do |m|
    m.serving_size = macrofood[:serving_size]
    m.protein = macrofood[:protein]
    m.carbs = macrofood[:carbs]
    m.fat = macrofood[:fat]
    m.food_type = macrofood[:food_type]
  end
end