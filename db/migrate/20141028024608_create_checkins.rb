class CreateCheckins < ActiveRecord::Migration
  def change
    create_table :checkins do |t|
      t.string :user_id
      t.string :cafename
      t.string :action

      t.timestamps
    end
  end
end
