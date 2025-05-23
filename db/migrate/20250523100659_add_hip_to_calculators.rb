class AddHipToCalculators < ActiveRecord::Migration[7.2]
  def change
    add_column :calculators, :hip, :float
  end
end
