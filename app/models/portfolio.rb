class Portfolio < ActiveRecord::Base
  belongs_to :user
  #has_many :picks
  has_and_belongs_to_many :stocks, -> { uniq } #, through: :picks #, source: :stock
  # accepts_nested_attributes_for :stocks
end
