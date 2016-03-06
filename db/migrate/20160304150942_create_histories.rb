class CreateHistories < ActiveRecord::Migration
  def change
    create_table :histories do |t|
      t.string :symbol
      t.date :date
      t.decimal :open
      t.decimal :high
      t.decimal :low
      t.decimal :close
      t.integer :volume
      t.decimal :adj_close

      t.timestamps null: false
    end
  end
end
