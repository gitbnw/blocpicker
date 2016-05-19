module AlertWatcher
  extend Resque::Plugins::Logger

  @queue = :alert_watcher

  def self.perform

    # Set all expired alerts to not active
    Alert.active_expired.update_all active: false
    
    # 
    stock_array = []
    # logger.info(puts Alert.all.inspect) 
    Alert.active.each do |alert|
      @stock = Stock.find_by(symbol: alert.stock.symbol)
      # logger.info("@stock: #{@stock}") 
      stock_array << @stock
    end
    
    logger.info("stock array: #{stock_array.uniq}") 
    


# if alert 

    unless stock_array.uniq.empty?
      Stock.quote_update(stock_array.uniq)
      
      Alert.active.each do |alert|
        @stock = Stock.find_by(symbol: alert.stock.symbol)
        
        #AlertWatcher.fire alert just testing
        
        if alert.position_initial == "above"
          if @stock.lasttradepriceonly <= alert.price_target
            AlertWatcher.fire alert
          end
        else
          if @stock.lasttradepriceonly >= alert.price_target
            AlertWatcher.fire alert
          end
        end
  
      end
    end
  end
  
  def self.fire alert
    AlertMailer.alert_fired(alert).deliver_now
    alert.update(fired: DateTime.now)
    alert.update(active: false)
    alert.save!
  end
  
end   