class PortfoliosController < ApplicationController

  def new

    @portfolio = Portfolio.new

  end

  def create

    @portfolio = Portfolio.new
    @portfolio.name = params[:portfolio][:name]
    @user = current_user
    @portfolio.user_id = current_user.id

    if @portfolio.save
      flash.now[:notice] = "Portfolio was saved."
    else

      flash.now[:alert] = "There was an error saving the Portfolio. Please try again."
      render :new
    end
    
    respond_to do |format|
      format.html
      format.js
    end
  end

  def show

    @portfolio = Portfolio.find(params[:id])
    
    gon.watch.myCount = @portfolio.stocks.count
    
    gon.watch.expired_stocks_ids = @portfolio.stocks.expired.pluck(:id)
raise
  end

  def destroy
    @portfolio = Portfolio.find(params[:id])

    if @portfolio.destroy
      flash.now[:notice] = "\"#{@portfolio.name}\" was deleted successfully."
      redirect_to root_path
    else
      flash.now[:error] = "There was an error deleting the portfolio."
      render :show
    end
  end


end
