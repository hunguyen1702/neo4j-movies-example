class CreateFriendShips < ActiveRecord::Migration
  def change
    create_table :friend_ships do |t|
      t.references :user, index: true, foreign_key: true
      t.integer :friend_user_id, index: true, references: [:user, :id]

      t.timestamps null: false
    end
  end
end
