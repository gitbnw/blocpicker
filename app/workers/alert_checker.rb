class AlertChecker
  @queue = :alert_queue

  def self.check
    @stock = Stock.find(Alert.stock_id)
    
  end

end   