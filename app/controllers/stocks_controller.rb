class StocksController < ApplicationController

  include StocksHelper

  def create


    @portfolio = Portfolio.find(params[:portfolio_id])
    
    @stock = Stock.find_or_create_by(stock_params)
    
    @remote_stock = Stock.where(stock_params).find_or_remote_find(stock_params)
    
    raise @remote_stock.inspect
    
    @portfolio.stocks << @remote_stock

 
        if @stock.save
          
          flash[:notice] = "Stock saved successfully."


          
    
        else
          flash[:alert] = "Stock failed to save."
          puts @stock.errors.full_messages
          
    
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
