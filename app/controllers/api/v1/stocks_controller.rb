 class Api::V1::StocksController < Api::V1::BaseController

include StocksHelper

     def refresh
         @stocks = Stock.find(params[:stock_ids])
         Stock.quote_update(Array.wrap(@stocks))
         @portfolio = Portfolio.where(params[:portfolio_id]).first
         render partial: "stocks/list", class: 'stockslist', locals: { stocks: @portfolio.stocks }
     end

 end
