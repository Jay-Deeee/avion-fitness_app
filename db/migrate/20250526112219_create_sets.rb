class CreateSets < ActiveRecord::Migration[7.2]
  def change
    create_table :sets do |t|
      t.references :exercise, null: false, foreign_key: true
      t.integer :value
      t.float :weight
      t.boolean :completed, default: false
      t.integer :position

      t.timestamps
    end
  end
end
