class CreateActivities < ActiveRecord::Migration
  def change
    create_table :activities do |t|
      t.string :user_id
      t.string :activity_code
      t.string :message

      t.timestamps
    end
  end
end
