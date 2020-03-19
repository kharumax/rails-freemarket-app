class CreateOrders < ActiveRecord::Migration[5.1]
  def change
    create_table :orders do |t|
      t.integer :provider_id,null: false
      t.integer :buyer_id ,null: false
      t.integer :order_status, null: false ,default: 0
      t.references :product,foreign_key: true
      t.timestamps
    end

    add_index :orders,[:provider_id,:buyer_id]
  end
end
