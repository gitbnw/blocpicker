module StocksHelper


    class RemoteUpdate
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

        base_query = "select * from yahoo.finance.quote where symbol in ( '#{stock_symbol}' )"
        query = URI.encode(base_query) << "&format=json&env=store%3A%2F%2Fdatatables.org%2Falltableswithkeys"

        response = get("?q=" << query)

        if response.success?

            decoded = JSON.parse response.body

            quote = decoded["query"]["results"]["quote"]
            #Array.wrap to handle if single hash or multiple in array
            return Array.wrap(quote)
         else
          # this just raises the net/http response that was raised
          puts 'error with yahoo api call'
          puts query
          puts response
        end

      end


    end

end
