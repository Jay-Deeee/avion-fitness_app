class SetDefaultMacroTargetToTrue < ActiveRecord::Migration[7.2]
  def change
    change_column :macros, :target, :boolean, :default => true
  end
end
