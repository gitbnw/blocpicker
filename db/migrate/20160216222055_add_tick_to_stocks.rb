class AddTickToStocks < ActiveRecord::Migration
  def change
    add_column :stocks, :tick, :string
  end
end
