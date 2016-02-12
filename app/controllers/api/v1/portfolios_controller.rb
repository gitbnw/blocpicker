 class Api::V1::PortfoliosController < Api::V1::BaseController

   def update
    RemoteUpdate.quote_update(stocks)
   end
 
 end