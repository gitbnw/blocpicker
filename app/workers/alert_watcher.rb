class AlertWatcher

  @queue = :alert_watcher

  def self.perform

    # Set all expired alerts to not active
    Alert.active_expired.active = False
    
    # 
    Alert.active.each do |alert|
      @stock = Stock.find_by(:symbol => alert.symbol)
      stock_array << @stock
    end
    
    Stock.quote_update(stock_array.uniq)

# if alert 
    Alert.active.each do |alert|
      @stock = Stock.find_by(:symbol => alert.symbol)

      if alert.position_initial == "above"
        if @stock.lasttradepriceonly <= alert.price_target
          fire_alert alert
        end
      else
        if @stock.lasttradepriceonly >= alert.price_target
          fire_alert alert
        end
      end

    end
  end
  
  def fire_alert alert
    AlertMailer.alert_fired(alert).deliver_now
    alert.fired = DateTime.now
    alert.active = False
    alert.save
  end
  
end   