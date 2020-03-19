class ProductsController < ApplicationController

  before_action :logged_in_user,only:[:new,:create,:edit,:update,:destroy]
  before_action :equal_product_user,only: [:edit,:update,:destroy]

  # ここに検索機能を付け足す（自力で作成する）
  def index
    @products = Product.paginate(page: params[:page]).search(params[:search])
  end

  def new
    @product = current_user.products.new
  end

  def create
    @product = current_user.products.build(product_params)
    if @product.save
      flash[:success] = "商品を出品しました"
      redirect_to root_url
    else
      redirect_to root_url
    end
  end

  # リクエストURLから、パラメータを受け取り返す
  def show
    @product = Product.find_by(id: params[:id])
  end

  def edit
    @product = Product.find_by(id: params[:id])
  end

  def update
    if @product.update_attributes(product_params)
      flash[:success] = "商品情報の更新が完了しました"
      redirect_to root_url
    else
      redirect_to root_url
    end
  end

  def destroy
    Product.find_by(id: params[:id]).destroy
    flash[:success] = "出品物の削除が完了しました"
    redirect_to root_url
  end

  private

  def product_params
    params.require(:product).permit(:title,:description,:price,:category,:image)
  end

  # 商品を出品したユーザーのみ、編集・削除画面に移行できる
  # 現在ログインしているユーザーが、商品ページの出品者のIDと同じか判定する
  def equal_product_user
    @product = Product.find_by(id: params[:id])
    @user = User.find_by(id: @product.user_id)
    redirect_to root_url unless current_user?(@user)
  end



end
