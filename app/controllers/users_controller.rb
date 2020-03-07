class UsersController < ApplicationController
  
  
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = "Welcome #{@user.name}"
      log_in @user
      redirect_to root_url
    else
      flash[:dander] = "Go Back!"
      render "new"
    end
  end
  
  def show
    @user = User.find_by(id: params[:id])
  end
  
  def edit

  end
  
  def update; end
  
  def destroy; end

  private

  def user_params
    params.require(:user).permit(:name,:email,:password,:password_confirmation)
  end

  def edit_params
    params.require(:user).permit(:name,:email,)
  end
  
  
end
