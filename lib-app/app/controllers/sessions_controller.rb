class SessionsController < ApplicationController
  def new
    @user = User.new
  end

  def create
    # log in user by
    # saving user's id into the session
    user_params = params.require(:user).permit(:email, :password)
    @user = User.confirm(user_params)
    if @user
      login(@user)
      flash[:notice] = "Successfully logged in."
      redirect_to @user
    else
      flash[:error] = "Incorrect email or password."
      redirect_to login_path
    end
  end

  def destroy
    logout
    flash[:notice] = "Successfully logged out."
    redirect_to root_path
  end

end
