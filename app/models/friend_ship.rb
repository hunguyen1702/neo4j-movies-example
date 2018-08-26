class FriendShip < ActiveRecord::Base
  belongs_to :user
  belongs_to :friend_user, foreign_key: :friend_id, class_name: User.name
end
