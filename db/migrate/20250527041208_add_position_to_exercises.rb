class AddPositionToExercises < ActiveRecord::Migration[7.2]
  def change
    add_column :exercises, :position, :integer
  end
end
