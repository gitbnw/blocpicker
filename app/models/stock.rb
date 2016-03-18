class Stock < ActiveRecord::Base

  include RemoteHelper

  #has_many :picks
  has_and_belongs_to_many :portfolios, -> { uniq } #, through: :picks
  has_many :portfolios_stocks
  has_many :histories
  validates :symbol, uniqueness: true

  default_scope { order('symbol ASC') }
  scope :freshest, -> { order(updated_at: :asc)}
  scope :oldest, -> { order(updated_at: :desc)}
  scope :expired, -> {where(["stocks.updated_at < ?", 6.seconds.ago])}

  def self.quote_update(stocks)

    
    stocks = Array.wrap(stocks)

    symbol_array = stocks.map(&:symbol)

    quote = Quote.find(symbol_array)

    stocks.each_with_index do |stock, i|

      stock.assign_attributes(
        averagedailyvolume: quote[i]["AverageDailyVolume"],
        change: quote[i]["Change"],
        dayslow: quote[i]["DaysLow"],
        dayshigh: quote[i]["DaysHigh"],
        yearlow: quote[i]["YearLow"],
        yearhigh: quote[i]["YearHigh"],
        marketcapitalization: quote[i]["MarketCapitalization"],
        lasttradepriceonly: quote[i]["LastTradePriceOnly"],
        daysrange: quote[i]["DaysRange"],
        name: quote[i]["Name"],
        symbol: quote[i]["Symbol"],
        volume: quote[i]["Volume"],
        stockexchange: quote[i]["StockExchange"]
      )
    
    end
    
    

  end


end
