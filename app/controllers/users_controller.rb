class UsersController < ApplicationController

  before_action :authenticate_user!

  def show

    @user = User.find(params[:id])
    @portfolios = @user.portfolios.where("portfolio.user" => current_user)

  end

end
