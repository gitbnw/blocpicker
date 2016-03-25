class AddLastTradeTimeToStocks < ActiveRecord::Migration
  def change
    add_column :stocks, :lasttradetime, :string
  end
end
