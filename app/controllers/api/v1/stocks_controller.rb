 class Api::V1::StocksController < Api::V1::BaseController
     
     def refresh
         @stocks = Stock.find(params[:ids])
     end
     
 end