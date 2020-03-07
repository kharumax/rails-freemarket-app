class User < ApplicationRecord
  attr_accessor :remember_token,:activation_token
  before_save :down_email
  before_create :create_activation_digest

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates :email,presence: true,uniqueness: true,format: {with: VALID_EMAIL_REGEX}

  validates :password,presence: true,length: { minimum: 6 },allow_nil: true

  def self.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
               BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

  def self.new_token
    SecureRandom.urlsafe_base64
  end

  def remember
    self.remember_token = User.new_token
    update_attribute(:remember_digest,User.digest(remember_token))
  end

  def authenticated?(attribute,token)
    digest = send("#{attribute}_digest") # ここでdiegest = :()_digestに変換している
    return false if digest.nil?
    BCrypt::Password.new(digest).is_password?(token)
  end

  def forget
    update_attribute(:remember_digest,nil)
  end

  def down_email
    self.email = email.downcase
  end

  def create_activation_digest
    self.activation_token = User.new_token
    self.activation_digest = User.digest(activation_token)
  end







  has_secure_password
end
