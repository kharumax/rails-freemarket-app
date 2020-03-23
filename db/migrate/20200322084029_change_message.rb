class ChangeMessage < ActiveRecord::Migration[5.1]

  def change
    rename_column :messages,:seller_id,:user_id
  end


end
