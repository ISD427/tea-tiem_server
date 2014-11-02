class AddCafenameToFriendships < ActiveRecord::Migration
  def change
    add_column :friendships, :cafename, :string
  end
end
