class Portfolio < ActiveRecord::Base
  belongs_to :user
  has_many :picks
  has_many :picked_stocks, through: :picks, source: :stock
end
