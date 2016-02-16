class PortfoliosController < ApplicationController

  def new

    @portfolio = Portfolio.new

  end


  def create

    @portfolio = Portfolio.new
    @portfolio.name = params[:portfolio][:name]
    @portfolio.user_id = current_user.id

    if @portfolio.save
      flash[:notice] = "Portfolio was saved."
      redirect_to @portfolio
    else

      flash.now[:alert] = "There was an error saving the Portfolio. Please try again."
      render :new
    end

  end

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
   
  def show
    @portfolio = Portfolio.find(params[:id])

    gon.watch.myCount = @portfolio.stocks.count
    puts @portfolio.stocks.count
    gon.watch.expired_stocks_ids = @portfolio.stocks.expired.pluck(:id)

  end

  def destroy
    @portfolio = Portfolio.find(params[:id])

    if @portfolio.destroy
      flash[:notice] = "\"#{@portfolio.name}\" was deleted successfully."
      redirect_to action: :index
    else
      flash[:error] = "There was an error deleting the portfolio."
      render :show
    end
  end


end
