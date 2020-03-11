class AccountActivationsController < ApplicationController


  def edit
    @user = User.find_by(email: params[:email])
    if @user && @user.authenticated?(:activation,params[:id]) && !@user.activated?
      @user.update_attribute(:activated,true)
      @user.update_attribute(:activated_at,Time.zone.now)
      log_in @user
      flash[:success] = "Account Activated!"
      redirect_to @user
    else
      flash[:danger] = "Activation like invalid"
      redirect_to root_url
    end
  end




end
