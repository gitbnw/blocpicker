class HistoryBuilder
  @queue = :history_queue

  def self.perform(stock_id)
    @stock = Stock.find(stock_id)
    History.find_or_complete(@stock)
  end

end   