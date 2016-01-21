class StocksController < ApplicationController
    
  def new
    
    @stock = Stock.new

  end    
  
end
