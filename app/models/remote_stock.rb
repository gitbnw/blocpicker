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

  
  def self.find(symbol)
    base_query = "select * from yahoo.finance.quote where symbol in ('#{symbol}')" 
    query = URI.encode(base_query) << "&format=json&env=store%3A%2F%2Fdatatables.org%2Falltableswithkeys&callback="
    puts "?q=" << query
    response = get("?q=" << query)

    if response.success?

        decoded = JSON.parse response.body
        results = decoded["query"]["results"]
        Stock.where(symbol: symbol).first_or_initialize(
            results["averagedailyvolume"], results["change"], results["dayslow"],
            results["dayshigh"], response["yearlow"], response["yearhigh"], response["marketcapitalization"],
            results["lasttradepriceonly"], results["daysrange"], results["name"], results["symbol"],
            results["volume"], results["stockexchange"])
    else
      # this just raises the net/http response that was raised
      raise response.response
    end
  end
  
end