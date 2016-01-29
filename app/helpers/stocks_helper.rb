module StocksHelper
  
    def self.request_remote(param)
      RemoteStock.find(param[:symbol])
    end
    
    class RemoteStock
      include HTTParty
      require 'uri'
      require 'json'
      
      base_uri "query.yahooapis.com/v1/public/yql"
     
      attr_accessor :averagedailyvolume, :change, :dayslow, :dayshigh, :yearlow, :yearhigh, :marketcapitalization, :lasttradepriceonly, :daysrange, :name, :symbol, :volume, :stockexchange
     
      def initialize(averagedailyvolume, change, dayslow, dayshigh, yearlow, yearhigh, marketcapitalization, lasttradepriceonly, daysrange, name, symbol, volume, stockexchange)
        self.averagedailyvolume = averagedailyvolume
        self.change = change
        self.dayslow = dayslow
        self.dayshigh = dayshigh
        self.yearlow = yearlow
        self.yearhigh = yearhigh
        self.marketcapitalization = marketcapitalization
        self.lasttradepriceonly = lasttradepriceonly
        self.daysrange = daysrange
        self.name = name
        self.symbol = symbol
        self.volume = volume
        self.stockexchange = stockexchange
      end
    
      
      def self.find(stock_symbol)

        base_query = "select * from yahoo.finance.quote where symbol = '#{stock_symbol}'" 
        query = URI.encode(base_query) << "&format=json&env=store%3A%2F%2Fdatatables.org%2Falltableswithkeys&callback="

        response = get("?q=" << query)

        if response.success?
            
            decoded = JSON.parse response.body

            quote = decoded["query"]["results"]["quote"]
            # need handling for if stock symbol does not resolve
            stock = Stock.find_by(symbol: stock_symbol)
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
              puts "hellooooo"
              stock

        else
          # this just raises the net/http response that was raised
          raise response.response
        end
        
      end
      
      
    end

end
