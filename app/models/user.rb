class User < ApplicationRecord
  has_many :user_stocks
  has_many :stocks, through: :user_stocks
  has_many :friendships
  has_many :friends, through: :friendships
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  def stock_already_track?(ticker_symbol)
    stock = Stock.check_db?(ticker_symbol)
    return false unless stock
    stocks.where(id: stock.id).exists?
  end

  def under_stock_limit?
    stocks.count < 10
  end

  def can_track_stock?(ticker_symbol)
    under_stock_limit? && !stock_already_track?(ticker_symbol)
  end

  def is_friend?(friend, user)
    # binding.pry
    already_friend = Friendship.check_friend?(user.id, friend.id)
    return false unless already_friend 
    # binding.pry
    friends.where(id: friend.id).exists?
  end
end
