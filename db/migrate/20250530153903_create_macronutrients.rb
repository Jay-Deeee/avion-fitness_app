class CreateMacronutrients < ActiveRecord::Migration[7.2]
  def change
    create_table :macronutrients do |t|
      t.string :food
      t.string :serving_size
      t.string :protein
      t.string :carbs
      t.string :fat
      t.string :food_type

      t.timestamps
    end
  end
end
