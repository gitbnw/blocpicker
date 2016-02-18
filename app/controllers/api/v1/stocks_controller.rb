class Api::V1::StocksController < Api::V1::BaseController

  include StocksHelper
  
  def refresh
    @portfolio = Portfolio.where(params[:portfolio_id]).first
    @stocks = Stock.quote_update(Stock.find(params[:stock_ids]))
    @stocks_changed = price_change_assign(@stocks)
    @stocks.map {|stock| stock.save }
    render json: @stocks
  end

  def price_change_assign(stocks)
    
    stocks.each do |stock|
      @change = stock.lasttradepriceonly - stock.lasttradepriceonly_was
      if @change > 0
        stock[:tick] = "up"
      elsif @change < 0
        stock[:tick] = "down"
      else
        stock[:tick] = "none"
      end
      
    end

  end 

end
