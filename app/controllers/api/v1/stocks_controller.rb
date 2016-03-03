class Api::V1::StocksController < Api::V1::BaseController

  include StocksHelper
  include ActionView::Helpers::NumberHelper

  def refresh
    @portfolio = Portfolio.where(params[:portfolio_id]).first
    @stocks = Stock.quote_update(Stock.find(params[:stock_ids]))
    @stocks_changed = price_change_assign(@stocks)
    @stocks.map {|stock| stock.save }
    render json: @stocks
  end

  def price_change_assign(stocks)
    stocks.each do |stock|
      @change = 100 * ((stock.lasttradepriceonly / stock.lasttradepriceonly ) - (stock.lasttradepriceonly_was / stock.lasttradepriceonly))
      
      if @change > 0.05
        stock[:tick] = "up"
      elsif @change < -0.05
        stock[:tick] = "down"
      else
        stock[:tick] = "none"
      end

    end

  end

end
