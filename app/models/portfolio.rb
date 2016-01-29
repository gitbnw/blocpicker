class Portfolio < ActiveRecord::Base
  belongs_to :user
  has_many :picks
  has_many :stocks, through: :picks #, source: :stock
  # accepts_nested_attributes_for :stocks
end
