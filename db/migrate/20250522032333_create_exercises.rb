class CreateExercises < ActiveRecord::Migration[7.2]
  def change
    create_table :exercises do |t|
      t.references :workout, null: false, foreign_key: true
      t.references :exercise_type, null: false, foreign_key: true
      t.integer :sets
      t.integer :value
      t.float :weight

      t.timestamps
    end
  end
end
