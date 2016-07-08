# Portfolio model to hold groups of stocks
class Portfolio < ActiveRecord::Base
  belongs_to :user
  has_and_belongs_to_many :stocks, -> { uniq }

  def self.from_dummy user
    dummy_portfolio = Portfolio.create(
      :name => Faker::Space.constellation,
      :user_id => user.id
    )
    dummy_portfolio.save!
    return dummy_portfolio
  end

end
