class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

         
  has_many :posts
  has_many :friendships, dependent: :destroy        # means>>  me ==> friendships   
  has_many :friends, through: :friendships      #show friends   #means>>  friendship ==> friend && friendships ==> friends

  has_many :friends_posts, through: :friends, source: :posts

  acts_as_voter

  has_many :comments
  
  attr_accessor :login


  validates :username, format: { without: /\s/ }
  validates :username,  presence: true, length: { maximum: 15 }
  #validate :username_uniqueness
  #validates_presence_of     :username
  validates_uniqueness_of   :username 

  # def username_uniqueness
  #   self.errors.add(:base, 'User with same username already exists. Please try with another username.') if User.where(:username => self.username).exists?
  # end

  def self.find_for_database_authentication warden_condition
    conditions = warden_condition.dup
    login = conditions.delete(:login)
    where(conditions).where(["lower(username) = :value OR lower(email) = :value", {value: login.strip.downcase}]).first
  end

  def is_friend?(another_user)
    #Friendship.where(user: self, friend: another_user).first == nil
    #friendships.where(friend: another_user)
    friends.include?(another_user)
  end

  def add_friend(another_user)
    friends << another_user
  end

  def check_friend?(u_id)
    another_user = User.find(u_id)
    friends.include?(another_user)
  end

  #show friends but I used association on the top 

  # def friends
  #   #go look at each of my friendship and get friend_id
  #   #then look up in User for the one with the id == friend_id

  #   # results = []
  #   # friendships.each do |fs|
  #   #   results << User.find(fs.friend_id)
  #   # end
  #   # results

  #second approach to show friends shorthand
  #   friendships.map {|fs| fs.friend}
  # end

  
  
end
