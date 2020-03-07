class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string :name
      t.string :email,unique: true
      t.string :password_digest
      t.string :image
      t.text   :introduction
      t.boolean :activated
      t.string :activation_digest
      t.datetime :activated_at
      t.string :remember_digest
      t.boolean :admin

      t.timestamps
    end
  end
end
