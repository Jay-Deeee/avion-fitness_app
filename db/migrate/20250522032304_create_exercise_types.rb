class CreateExerciseTypes < ActiveRecord::Migration[7.2]
  def change
    create_table :exercise_types do |t|
      t.string :name
      t.integer :category
      t.integer :unit

      t.timestamps
    end
  end
end
