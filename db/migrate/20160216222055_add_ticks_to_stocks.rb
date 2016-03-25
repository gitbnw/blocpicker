class AddTicksToStocks < ActiveRecord::Migration
  def change
    add_column :stocks, :ticks, :string
  end
end
