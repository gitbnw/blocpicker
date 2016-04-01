class HistoriesController < ApplicationController

  def show

    @stock = Stock.find(params[:stock_id])

    @histories =  History.where("symbol = ?", @stock.symbol)

    respond_to do |format|
      format.html
      format.js
    end
  end

end
