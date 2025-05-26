class RenameSetsToExerciseSets < ActiveRecord::Migration[7.2]
  def change
    rename_table :sets, :exercise_sets
  end
end
