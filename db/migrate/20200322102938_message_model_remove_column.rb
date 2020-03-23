class MessageModelRemoveColumn < ActiveRecord::Migration[5.1]
  def change
    remove_column :messages,:product_id,:integer
  end
end
