class AddBounceToStocks < ActiveRecord::Migration
  def change
    add_column :stocks, :bounce, :string
  end
end
