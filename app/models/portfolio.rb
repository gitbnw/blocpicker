# Portfolio model to hold groups of stocks
class Portfolio < ActiveRecord::Base
  belongs_to :user
  has_and_belongs_to_many :stocks, -> { uniq }

end
