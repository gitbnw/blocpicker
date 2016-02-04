class Pick < ActiveRecord::Base
  belongs_to :portfolio
  belongs_to :stock  
  validates :portfolio_id, presence: true
  validates :stock_id, presence: true  
end
