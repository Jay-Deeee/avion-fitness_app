class RemoveSetsValueWeightFromExercises < ActiveRecord::Migration[7.2]
  def change
    remove_column :exercises, :sets, :integer
    remove_column :exercises, :value, :integer
    remove_column :exercises, :weight, :float
  end
end
