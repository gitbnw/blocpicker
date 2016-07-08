class UsersController < ApplicationController

  before_action :authenticate_user!, only: [:show]

  def show

    @user = User.find(params[:id])
    @portfolios = @user.portfolios.where("portfolio.user" => current_user)

  end
  
    def testdrive

    #create dummy login
    @user = User.from_dummy
    
    #create dummy portfolios & stocks
    @portfolios = 3.times do |p| 
      @portfolio = Portfolio.from_dummy @user
      3.times do |s|
        @stock = Stock.from_dummy
        unless @portfolio.stocks.where(symbol: @stock.symbol).exists?
          @portfolio.stocks << @stock 
        end
      end
    end
    
    respond_to do |format|
      format.html
      format.js
    end
    
  end

end
