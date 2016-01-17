class CreateStocks < ActiveRecord::Migration
  def change
    create_table :stocks do |t|
      t.string :symbol
      t.string :name
      t.decimal :price
      t.decimal :change
      t.decimal :volume

      t.timestamps null: false
    end
  end
end
