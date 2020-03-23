class CreateMessages < ActiveRecord::Migration[5.1]
  def change
    create_table :messages do |t|
      t.integer :room_id,null: false
      t.integer :seller_id,null: false
      t.integer :product_id,null: false
      t.string  :message,null: false

      t.timestamps
    end
  end
end
