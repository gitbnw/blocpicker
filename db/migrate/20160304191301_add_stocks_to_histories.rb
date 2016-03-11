class AddStocksToHistories < ActiveRecord::Migration
  def change
    add_column :histories, :stock_id, :integer
  end
end
