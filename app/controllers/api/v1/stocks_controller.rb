 class Api::V1::StocksController < Api::V1::BaseController

include StocksHelper

     def refresh
         @portfolio = Portfolio.where(params[:portfolio_id]).first
         @stocks = Stock.quote_update(Array.wrap(Stock.find(params[:stock_ids])))
         @stocks_changed = []
         @stocks.map {|stock| stock.lasttradepriceonly_changed? ? @stocks_changed << stock : stock}
         @stocks.map {|stock| stock.save }
         render json: @stocks_changed.to_json, status: 201
        #  render partial: "stocks/list", class: 'stockslist', locals: { stocks: @portfolio.stocks }
     end

end
