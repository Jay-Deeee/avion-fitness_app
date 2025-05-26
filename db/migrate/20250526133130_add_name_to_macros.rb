class AddNameToMacros < ActiveRecord::Migration[7.2]
  def change
    add_column :macros, :name, :string
  end
end
