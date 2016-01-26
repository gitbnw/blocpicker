class AddDetailsToStocks < ActiveRecord::Migration
  def change
    add_column :stocks, :averagedailyvolume, :integer
    add_column :stocks, :dayslow, :decimal
    add_column :stocks, :dayshigh, :decimal
    add_column :stocks, :yearlow, :decimal
    add_column :stocks, :yearhigh, :decimal
    add_column :stocks, :marketcapitalization, :string
    add_column :stocks, :lasttradepriceonly, :decimal
    add_column :stocks, :daysrange, :string
    add_column :stocks, :stockexchange, :string
  end
end
