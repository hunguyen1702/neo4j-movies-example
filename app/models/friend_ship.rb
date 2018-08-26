class FriendShip < ActiveRecord::Base
  belongs_to :user
  belongs_to :friend_user
end
