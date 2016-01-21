class UsersController < ApplicationController
    

  
 def show
   
  @user = User.find(params[:id])
  @portfolios = @user.portfolios.where("portfolio.user" => current_user)
  
 end
  
end
