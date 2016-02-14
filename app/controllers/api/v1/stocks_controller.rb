 class Api::V1::StocksController < Api::V1::BaseController

include StocksHelper

     def refresh
         @stocks = Stock.find(params[:ids])
         Stock.quote_update(@stocks)
         render json: @stocks.to_json, status: 200
     end

 end
