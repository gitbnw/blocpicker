class AlertsController < ApplicationController

  def new

    @alert = Alert.new

  end   
  
  def create

    @stock = Stock.find(params[:stock][:id])
    @alert.price_initial = @stock.lasttradepriceonly
    @alert.price_target = params[:alert][:price_target]
    @alert.expire = params[:alert][:expire]

    if @alert.save
      flash.now[:notice] = "Alert was saved."
      redirect_to @portfolio
    else

      flash.now[:alert] = "There was an error saving the Alert. Please try again."
      render :new
    end

  end  
  
end
