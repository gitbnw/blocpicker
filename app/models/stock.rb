class Stock < ActiveRecord::Base

    include StocksHelper

    #has_many :picks
    has_and_belongs_to_many :portfolios, -> { uniq } #, through: :picks
    has_many :portfolios_stocks
    validates :symbol, uniqueness: true  

    default_scope { order('symbol ASC') }
    scope :freshest, -> { order(updated_at: :asc)}
    scope :oldest, -> { order(updated_at: :desc)}
    
    def self.quote_update(stock)
      quote = RemoteStock.find(stock[:symbol])
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
                        stockexchange: quote["StockExchange"]
                        ) 

    end

    private

    # def self.update_or_create(attributes)
    #   assign_or_new(attributes)
    # end

    def self.assign_or_new(attributes)

      obj = first || new
      obj.assign_attributes(attributes)
      obj
    end

    def self.request_remote
      RemoteStock.find(stock)
    end
    
    def request_remote
      self.class.request_remote
    end
end
