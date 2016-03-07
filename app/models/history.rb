class History < ActiveRecord::Base
    
  include RemoteHelper
  
  belongs_to :stock

  default_scope { order('symbol ASC') }
  
  scope :current, -> { where(date: DateTime.now.to_date - 90..DateTime.now.to_date) }

  def self.find_or_complete(stock)
    

    start_date = DateTime.now.to_date - 90
    end_date = DateTime.now.to_date

    histories_response = HQuote.quote(stock.symbol, start_date, end_date)
    
    histories_response.map do |response|
       history = History.where(:date => response["Date"]).first_or_initialize
       
      history.assign_attributes(
        stock_id: stock.id,
        symbol: response["Symbol"],
        date: response["Date"],
        open: response["Open"],
        high: response["High"],
        low: response["Low"],
        close: response["Close"],
        volume: response["Volume"],
        adj_close: response["Adj_Close"]
      )
      
      history.save!
      
    end
  end
end
