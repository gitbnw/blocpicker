class StocksController < ApplicationController

include StocksHelper


  def create

     @portfolio = Portfolio.find(params[:portfolio_id])
     @stock = @portfolio.stocks.request_remote(stock_params)

     if @stock.save
       flash[:notice] = "Stock saved successfully."

     else
       puts  @stock.errors.full_messages
       flash[:alert] = "Stock failed to save."

     end

    respond_to do |format|
       format.html
       format.js
    end

  end

  def update

     @portfolio = Portfolio.find(params[:portfolio_id])
     @stock = @portfolio.stocks.request_remote(stock_params)

     if @stock.save
       flash[:notice] = "Stock saved successfully."

     else
       puts  @stock.errors.full_messages
       flash[:alert] = "Stock failed to save."

     end

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
