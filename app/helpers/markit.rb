
module Markit
    
  class MarkitFinance
      
    def find_quote symbol
      Quote.new HTTParty.get("http://dev.markitondemand.com/MODApis/Api/v2/Quote?symbol=#{symbol}")
    end

    
  end
    
  class Quote
    def initialize(response)
      @response = response
    end

    def output
      @response#["StockQuote"]["results"]["quote"]
    end
  end
  

    


end
