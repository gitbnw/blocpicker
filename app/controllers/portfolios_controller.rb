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

  def show
    @portfolio = Portfolio.find(params[:id])
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
