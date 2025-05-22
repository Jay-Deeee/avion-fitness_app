class Macros < ActiveRecord::Migration[7.2]
  def change
    create_table :macros do |t|
      t.integer :calories, null: false
      t.float :protein, null: false
      t.float :carbohydrates, null: false
      t.float :fats, null: false
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
