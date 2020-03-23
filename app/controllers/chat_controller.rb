class ChatController < ApplicationController

  before_action :logged_in_user

  def create
    @seller_id = params[:seller_id]
    @product_id = params[:product_id]
    @talk_room = TalkRoom.where(seller_id: @seller_id,buyer_id: current_user.id,product_id: @product_id)
    # もし、トークルームが出来ていないなら、ここで作成する
    if @talk_room.blank?
      @talk_room = TalkRoom.create(seller_id: @seller_id, buyer_id: current_user.id,product_id: @product_id)
    end
    # where句で指定すると、クエリの返り値が複数になるので、ここではfirstメソッドでクエリの返り値を一つにする必要がある
    @talk_room = TalkRoom.where(seller_id: @seller_id,buyer_id: current_user.id,product_id: @product_id).first
    puts @talk_room.id
    redirect_to controller: "chat", action: :show, id: @talk_room
    # ここでトークルームIDと一緒にshowアクションに遷移させる
  end

  def show
    @talk_room = TalkRoom.find_by(id: params[:id])
    @chat_messages = Message.where(room_id: @talk_room.id).order(:created_at)
  end

end

