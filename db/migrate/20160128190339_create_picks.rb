class CreatePicks < ActiveRecord::Migration
  def change
    create_table :picks do |t|
      t.references :portfolio, index: true
      t.references :stock, index: true

      t.timestamps null: false
    end
  end
end
