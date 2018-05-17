class UsersController < ApplicationController

  def new                             #render signup form
    @user = User.new
  end

  def show
    @user = User.find(params[:id])
  end

  def create
    @user = User.new(user_params)
    if @user.save
      log_in @user
      flash[:success] = 'Welcome to the Sample App!'
      redirect_to @user              #eq is redirect_to user_url(@user)
    else
      render 'new'                  #render view 'new.html.erb'
    end
  end

  private

    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end

end
