class CreatePortfolios < ActiveRecord::Migration
  def change
    create_table :portfolios do |t|
      t.references :stock, index: true, foreign_key: true
      t.timestamps null: false
    end
  end
end
