class AddTimestampsToPortfoliosStocks < ActiveRecord::Migration
    def self.up # Or `def up` in 3.1
        change_table :portfolios_stocks do |t|
            t.timestamps
        end
    end
    def self.down # Or `def down` in 3.1
        remove_column :portfolios_stocks, :created_at
        remove_column :portfolios_stocks, :updated_at
    end
end
