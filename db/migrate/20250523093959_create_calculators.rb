class CreateCalculators < ActiveRecord::Migration[7.2]
  def change
    create_table :calculators do |t|
      t.float :weight
      t.float :height
      t.float :waist_line
      t.float :neck_line
      t.date :date
      t.float :bmi
      t.float :body_fat
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
