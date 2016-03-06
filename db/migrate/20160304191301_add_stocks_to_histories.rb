class AddStocksToHistories < ActiveRecord::Migration
  def change
    add_foreign_key :histories, :stocks
  end
end
