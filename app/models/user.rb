class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  has_many :posts
  attr_accessor :login
  
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable


  validates :username, format: { without: /\s/ }
  validates :username,  presence: true, length: { maximum: 15 }
  validate :username_uniqueness

  def username_uniqueness
    self.errors.add(:base, 'User with same username already exists. Please try with another username.') if User.where(:username => self.username).exists?
  end

  def self.find_for_database_authentication warden_condition
    conditions = warden_condition.dup
    login = conditions.delete(:login)
    where(conditions).where(["lower(username) = :value OR lower(email) = :value", {value: login.strip.downcase}]).first
  end
  
end
