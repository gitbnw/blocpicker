class StocksController < ApplicationController
    
  def new
    
    @stock = Stock.new

  end  
  
  def create

     @portfolio = Portfolio.find(params[:portfolio_id])
     @stock = @portfolio.stocks.find_or_create_by(stock_params)

 
     if @stock.save
       flash[:notice] = "Stock saved successfully."

     else
       flash[:alert] = "Stock failed to save."
       
     end
    
    # redirect_to [@portfolio]
   
    respond_to do |format|
       format.html
       format.js
    end
     
  end   
  
private
 
   def stock_params
     params.require(:stock).permit(:symbol)
   end   
   
   
end
