class AlertsController < ApplicationController

  def new

    @alert = Alert.new

  end   
  
  def create
    @alert = Alert.new
    @stock = Stock.find_or_initialize_by(symbol: params[:alert][:symbol]) do |new_stock|
      puts 'new stock remote call'
      new_stock.class.quote_update(new_stock)
    end    
    
    @alert.price_initial = @stock.lasttradepriceonly
    @alert.price_target = params[:alert][:price_target]

    @alert.expire = DateTime.strptime(params[:alert][:expire], '%m/%d/%Y %H:%M')
    @alert.stock = @stock
    @alert.user = current_user
    @user = current_user


    if @alert.save && @stock.save
      flash.now[:notice] = "Alert was saved."

    else

      flash.now[:alert] = "There was an error saving the Alert. Please try again."

    end
    
    respond_to do |format|
      format.html
      format.js
    end
    
  end 
  
  def initial_price
    @price = params[:price].to_f
    respond_to do |format|
      format.html
      format.js
    end
    
  end
end
