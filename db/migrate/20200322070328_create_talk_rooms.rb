class CreateTalkRooms < ActiveRecord::Migration[5.1]
  def change
    create_table :talk_rooms do |t|
      t.integer :buyer_id,null: false
      t.integer :seller_id,null: false
      t.integer :product_id,null: false
      t.timestamps
    end
  end
end
