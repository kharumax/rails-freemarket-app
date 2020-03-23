class TalkRoomChannel < ApplicationCable::Channel

  def subscribed
    stream_for "talk_room_#{params[:room_id]}"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def speak(data)
    message = Message.create(
        room_id: data["room_id"],
        user_id: data["user_id"],
        message: data["message"]
         )
    puts "This is speak method"
    puts "This is message : #{message.message}"
    TalkRoomChannel.broadcast_to "talk_room_#{data['room_id']}",content: render_message(message)
  end

  private

  def render_message(message)
    puts "This is message : #{message.message}"
    puts "Fin This point"
    ApplicationController.renderer.render(
        partial: 'chat_messages/chat_message',
        locals: { chat_message: message, current_user: message.user })
  end
end
