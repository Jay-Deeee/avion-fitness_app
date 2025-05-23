class AddRestTimerToUser < ActiveRecord::Migration[7.2]
  def change
    add_column :users, :rest_time, :integer, default: 60
  end
end
