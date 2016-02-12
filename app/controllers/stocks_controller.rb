class StocksController < ApplicationController

  include StocksHelper
  

  def create
      
    @portfolio = Portfolio.find(params[:portfolio_id])
    
    @stock = Stock.find_or_initialize_by(stock_params) do |new_stock|
      puts 'new stock remote call'
      new_stock.class.quote_update(Array.wrap(new_stock))
    end

    @portfolio_stock = @portfolio.stocks.where(stock_params).exists?
    
    if @portfolio.stocks.where(stock_params).exists?
      
      puts 'stock exists in portfolio, will not be saved'
      flash[:alert] = "Stock exists in portfolio."      
    
    elsif @stock.save
    
      puts 'stock has saved and not in portfolio'
      @portfolio.stocks << @stock

      flash[:notice] = "Stock saved successfully."

    else
      puts 'stock did not save'
      flash[:alert] = "Stock failed to save."
      puts @stock.errors.full_messages

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
