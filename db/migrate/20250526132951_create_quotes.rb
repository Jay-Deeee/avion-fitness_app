class CreateQuotes < ActiveRecord::Migration[7.2]
  def change
    create_table :quotes do |t|
      t.string :quote

      t.timestamps
    end
  end
end
