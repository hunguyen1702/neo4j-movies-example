class CreateFriendShips < ActiveRecord::Migration
  def change
    create_table :friend_ships do |t|
      t.references :user, index: true, foreign_key: true
      t.references :friend_user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
