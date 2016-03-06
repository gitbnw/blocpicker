class HistoriesController < ApplicationController
    
  def show
      
    @stock = Stock.find(params[:stock_id])
    @histories = History.find_by symbol: @stock.symbol

  end    
  
end
