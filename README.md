# Fitness Tracker Application
A Ruby on Rails fitness tracking application that allows users to log workouts, add exercises, and track sets with weights, reps, or time-based metrics.

### Features
  - 📅 Select a date and create workouts
  - 🏋️ Add exercises to a workout
  - 🔢 Track sets with:
    - Reps or time (seconds → formatted display)
    - Weight
    - Completion status
  - 🔁 Reorder exercises and sets (move up/down)
  - 📝 Edit and delete sets and exercises via modals
  - ⏱️ Rest timer integration when completing sets
  - 📊 Clean UI with responsive layout (Flexbox + Grid)

### Tech Stack
  - Ruby on Rails
  - Stimulus (Hotwire) – for modals and interactivity
  - Turbo – for navigation
  - SCSS (Vanilla CSS) – custom styling (no Tailwind)
  - Flatpickr – date picker
  - FontAwesome – icons

## Setup Instructions

1. Clone the repository
```
git clone https://github.com/YOUR_USERNAME/YOUR_REPO_NAME.git
cd YOUR_REPO_NAME
```
2. Install dependencies
```
bundle install
```
3. Setup the database
```
rails db:create
rails db:migrate
```
4. Start the server
```
rails server
```

## Required Packages / Dependencies
### Gems
  - rails
  - sqlite3 (or your configured DB)
  - sassc-rails
  - importmap-rails
  - turbo-rails
  - stimulus-rails
### JavaScript (Importmap)
  - @hotwired/stimulus
  - @hotwired/turbo-rails
  - flatpickr

## Key Implementation Notes
### Stimulus Modals
  - Custom modal system using Stimulus
  - No external modal library used
  - Controllers located in:
    ```
    app/javascript/controllers/
    ```
### Nested Resources
  - Workouts → Exercises → ExerciseSets
  - Routes follow:
    ```
    /workouts/:workout_id/exercises/:exercise_id/exercise_sets/:id
    ```
