class CreatePortfoliosStocks < ActiveRecord::Migration
  def change
    create_table :portfolios_stocks do |t|
      t.belongs_to :portfolio, index: true
      t.belongs_to :stock, index: true
    end
    add_index :portfolios_stocks, [:portfolio_id, :stock_id], :unique => true
  end
end
