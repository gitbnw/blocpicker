class StocksController < ApplicationController

  include Yahoo

  def create

    @portfolio = Portfolio.find(params[:portfolio_id])

    @stock = Stock.add_update_stock stock_params

    @portfolio_stock = @portfolio.stocks.where(stock_params).exists?

    if @portfolio.stocks.where(stock_params).exists?

      puts 'stock exists in portfolio, will not be saved'
      flash[:alert] = "Stock exists in portfolio."

    elsif @stock.save

      puts 'stock has saved and not in portfolio'

      @portfolio.stocks << @stock

      Resque.enqueue(HistoryBuilder, @stock.id)

      flash.now[:notice] = "Stock saved successfully."

    else
      puts 'stock did not save'
      flash[:alert] = "Stock failed to save."
      puts @stock.errors.full_messages

    end

    respond_to do |format|
      format.html
      format.js
    end

  end

  def refresh
    @stocks = Stock.find(params[:stock_ids])

    respond_to do |format|
      format.html
      format.js
    end
  end

  def history
    @stocks = Stock.find(params[:stock_ids])

    respond_to do |format|
      format.html
      format.js
    end

  end

  private

  def stock_params
    params.require(:stock).permit(:symbol)
  end


end
