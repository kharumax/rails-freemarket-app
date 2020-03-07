class UsersController < ApplicationController
  before_action :logged_in_user,only: [:edit,:update,:index,:destroy]
  before_action :correct_user,only: [:edit,:update]
  before_action :amdin_user,only: [:destroy]

  def new
    @user = User.new
  end

  def index
    @users = User.paginate(page: params[:page])
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
    @user = User.find_by(id: params[:id])
  end
  
  def update
    @user = User.find_by(id: params[:id])
    if @user.update_attributes(user_params)
      flash[:success] = "Profile Updated"
      redirect_to @user
    else
      render "edit"
    end
  end
  
  def destroy
    User.find_by(id: params[:id]).destroy
    flash[:success] = "Delete Complete"
    redirect_to users_url
  end

  private

  def user_params
    params.require(:user).permit(:name,:email,:password,:password_confirmation)
  end

  def logged_in_user
    unless logged_in? # ここでTrueが返ってきたら、ログインしていない
      store_location
      flash[:dander] = "Please Login Go Back"
      redirect_to login__url
    end
  end

  def correct_user
    @user = User.find_by(id: params[:id])
    redirect_to root_url unless current_user?(@user)
  end

  def admin_user
    redirect_to root_url unless current_user.admin?
  end


  #def edit_params
  #  params.require(:user).permit(:name,:email,:image,:introduction)
  #end
  
  
end
