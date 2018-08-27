class FriendShip < ActiveRecord::Base
  belongs_to :user
  belongs_to :friend_user, class_name: User.name
end
