class AddTargetAndMealToMacros < ActiveRecord::Migration[7.2]
  def change
    add_column :macros, :target, :boolean
    add_column :macros, :meal, :string
  end
end
