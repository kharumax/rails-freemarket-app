class Product < ApplicationRecord
  belongs_to :user
  validates :user_id,presence: true
  validates :title,presence: true,length: {maximum: 30}
  validates :description,presence: true,length: {maximum: 300}
  # 自作のバリデーションの場合は単数形
  validate :product_image_size

  default_scope -> { order(created_at: :desc) }
  # 画像投稿の設定
  mount_uploader :image,ImageUploader

  def self.search(search)
    if search
      where(['title LIKE ?',"%#{search}%"]) # ここで出品名にキーワードを含む出品物を返す
    else
      all # 検索フォームからの値が存在しない場合は全て返す
    end
  end
  
  private

  def product_image_size
    if image.size > 5.megabytes
      errors.add(:image,"Should ne less than 5MB")
    end
  end





end
