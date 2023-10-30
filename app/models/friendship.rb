class Friendship < ApplicationRecord
  belongs_to :user
  belongs_to :friend, class_name: "User"

  def self.check_friend?(current_user_id, friend_id)
    where(user_id: current_user_id,  friend_id: friend_id).first
  end
end
