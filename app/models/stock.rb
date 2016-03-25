class Stock < ActiveRecord::Base

  include RemoteHelper

  #has_many :picks
  has_and_belongs_to_many :portfolios, -> { uniq } #, through: :picks
  has_many :portfolios_stocks
  has_many :histories
  validates :symbol, uniqueness: true
  serialize :ticks, Array

  default_scope { order('symbol ASC') }
  scope :freshest, -> { order(updated_at: :asc)}
  scope :oldest, -> { order(updated_at: :desc)}
  scope :expired, -> {where(["stocks.updated_at < ?", 6.seconds.ago])}
  
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

    stocks = Array.wrap(stocks)

    symbol_array = stocks.map(&:symbol)

    quote = Quote.find(symbol_array)

    stocks.each_with_index do |stock, i|
      
    if !stock.id.nil?

      # logger.debug "debug this idiot #{quote[i]["LastTradeTime"]}"
      # logger.debug "debug this idiot #{stock.lasttradetime}"
      # logger.debug "debug this idiot #{stock.lasttradetime} is less than #{quote[i]["LastTradeTime"]} : #{stock.lasttradetime < quote[i]["LastTradeTime"]}"
      # logger.debug "debug this idiot #{quote[i]["LastTradeDate"]}"
      # logger.debug "debug this idiot #{stock.lasttradedate}"
      # logger.debug "debug this idiot #{stock.lasttradedate} is less than #{quote[i]["LastTradeDate"]} : #{stock.lasttradedate < quote[i]["LastTradeDate"]}"      
    end
      
      @date = Date.strptime(quote[i]["LastTradeDate"], '%m/%d/%Y')

      Stock.apply_update(stock, quote[i]) if stock.id.nil? || stock.lasttradedate <= quote[i]["LastTradeDate"] && stock.lasttradetime < quote[i]["LastTradeTime"]
      
    end
    
    

  end


end
