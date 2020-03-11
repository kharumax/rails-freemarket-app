class CreateProducts < ActiveRecord::Migration[5.1]
  def change
    create_table :products do |t|
      t.string :title
      t.references :user,foreign_key: true
      t.text :description
      t.integer :price
      t.string :category
      t.string :image
      t.timestamps
    end
    add_index :products,[:user_id,:created_at]
  end
end
