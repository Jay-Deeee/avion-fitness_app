class AddLoggedDateToMacros < ActiveRecord::Migration[7.2]
  def change
    add_column :macros, :logged_date, :date
  end
end
