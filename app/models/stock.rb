class Stock < ActiveRecord::Base

  include Yahoo

  #has_many :picks
  has_and_belongs_to_many :portfolios, -> { uniq } #, through: :picks
  has_many :portfolios_stocks
  has_many :histories
  validates :symbol, uniqueness: true
  serialize :ticks, Array

  default_scope { order('symbol ASC') }
  scope :freshest, -> { order(updated_at: :asc)}
  scope :oldest, -> { order(updated_at: :desc)}
  scope :expired, -> {where(["stocks.updated_at < ?", 60.seconds.ago])}
  
  def self.apply_update(stock, quote)
    
    stock.assign_attributes(
      averagedailyvolume: quote["AverageDailyVolume"],
      change: quote["Change"],
      dayslow: quote["DaysLow"],
      dayshigh: quote["DaysHigh"],
      yearlow: quote["YearLow"],
      yearhigh: quote["YearHigh"],
      marketcapitalization: quote["MarketCapitalization"],
      lasttradepriceonly: quote["LastTradePriceOnly"],
      daysrange: quote["DaysRange"],
      name: quote["Name"],
      symbol: quote["Symbol"],
      volume: quote["Volume"],
      lasttradedate: quote["LastTradeDate"],
      lasttradetime: quote["LastTradeTime"],
      stockexchange: quote["StockExchange"]
    )

  end
  
  def self.quote_update(stocks)

    @stocks = Array.wrap(stocks)
    @symbol_array = @stocks.map(&:symbol)
    @quote = Yahoo::YQLFinance.new.find_quote(@symbol_array).output
    @quotes = Array.wrap(@quote)

    @stocks.each_with_index do |stock, i|
      Stock.apply_update(stock, @quotes[i]) if stock.id.nil? || stock.lasttradedate <= @quotes[i]["LastTradeDate"] && stock.lasttradetime < @quotes[i]["LastTradeTime"]
    end
    
  end

end
