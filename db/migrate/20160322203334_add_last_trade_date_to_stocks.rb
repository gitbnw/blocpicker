class AddLastTradeDateToStocks < ActiveRecord::Migration
  def change
    add_column :stocks, :lasttradedate, :string
  end
end
