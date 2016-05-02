class AddNameToPortfolios < ActiveRecord::Migration
  def change
    add_column :portfolios, :name, :string
    add_reference :portfolios, :user, index: true, foreign_key: true
  end
end
