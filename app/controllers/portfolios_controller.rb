class PortfoliosController < ApplicationController
    
  def new
    @portfolio = Portfolio.new
  end

  def create
    
    @portfolio.user = current_user


  end
   
end
