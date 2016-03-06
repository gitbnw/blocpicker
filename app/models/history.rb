class History < ActiveRecord::Base
    
  include RemoteHelper
  
  belongs_to :stock
  
  validates :symbol, uniqueness: true

  default_scope { order('symbol ASC') }

  def self.history_update(symbol, start_date, end_date)
    
    histories = History.find_or_initialize_by(:symbol => symbol, :date => (DateTime.now.to_date - 365)..(DateTime.now.to_date))
    puts histories
    
    history_response = HQuote.quote(symbol, start_date, end_date)
    
    histories.each_with_index do |history, i|
        

      history.assign_attributes!(
        date: quote[i]["Date"],
        open: quote[i]["Open"],
        high: quote[i]["High"],
        low: quote[i]["Low"],
        close: quote[i]["Close"],
        volume: quote[i]["Volume"],
        adj_close: quote[i]["Adj_Close"],
      )

    end
    
  end    
end
