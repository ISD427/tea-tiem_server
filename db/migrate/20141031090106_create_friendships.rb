class CreateFriendships < ActiveRecord::Migration
  def change
    create_table :friendships do |t|
      t.string :source_id
      t.string :target_id
      t.integer :count
      t.boolean :first_time

      t.timestamps
    end
  end
end
