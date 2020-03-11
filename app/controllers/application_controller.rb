class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper

  def logged_in_user
    unless logged_in? # ここでTrueが返ってきたら、ログインしていない
      store_location
      flash[:dander] = "Please Login Go Back"
      redirect_to login__url
    end
  end





end
