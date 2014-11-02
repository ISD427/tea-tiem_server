class AddTimeToFriendships < ActiveRecord::Migration
  def change
    add_column :friendships, :time, :timestamp
  end
end
