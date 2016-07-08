class AutoPilotController < ApplicationController

  def takeoff

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
  end

end
