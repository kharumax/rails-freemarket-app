class SessionsController < ApplicationController

  def new
  end

  def create
    @user = User.find_by(email: params[:session][:email])
    if @user && @user.authenticate(params[:session][:password])
      if @user.activated?
        log_in @user
        params[:session][:remember_me] == "1" ? remember(@user) : forget(@user)
        redirect_or_back root_url
      else
        message = "Check your email or please activate yout account"
        flash[:warning] = message
        redirect_to root_url
      end
    else
      render "new"
    end

  end

  def destroy
    if logged_in?
      log_out
      redirect_to root_url
    end
  end

end
