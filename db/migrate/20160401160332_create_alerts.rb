class CreateAlerts < ActiveRecord::Migration
  def change
    create_table :alerts do |t|
      t.date :start
      t.datetime :expire
      t.decimal :price_target
      t.decimal :price_initial
      t.belongs_to :user, index: true
      t.belongs_to :stock, index: true

      t.timestamps null: false
    end
  end
end
