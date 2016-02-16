class Api::V1::StocksController < Api::V1::BaseController

  include StocksHelper
  
    @stocks_changed_price_up = []
    @stocks_changed_price_down = []
    @stocks_changed_price_stay = []
    @stocks_changed = {}
    
  # def refresh
  #   @portfolio = Portfolio.where(params[:portfolio_id]).first
  #   @stocks = Stock.quote_update(Stock.find(params[:stock_ids]))
  #   @stocks_changed = price_change_assign(@stocks)
  #   @stocks.map {|stock| stock.save }
  #   render @stocks
  # end

  # def price_change_assign(stocks)
    
  #   @stocks_changed_price_up = []
  #   @stocks_changed_price_down = []
  #   @stocks_changed_price_stay = []
  #   @stocks_changed = {}

  #   stocks.each do |stock|
  #     @change = stock.lasttradepriceonly - stock.lasttradepriceonly_was
  #     if @change > 0
  #       @stocks_changed_price_up << stock
  #     elsif @change < 0
  #       @stocks_changed_price_down << stock
  #     else
  #       @stocks_changed_price_stay << stock
  #     end
  #   end

    # @stocks_changed[:stocks_changed_price_up] = @stocks_changed_price_up
    # @stocks_changed[:stocks_changed_price_down] = @stocks_changed_price_down
    # @stocks_changed[:stocks_changed_price_stay] = @stocks_changed_price_stay
    
    # return @stocks_changed
    
  end




end
