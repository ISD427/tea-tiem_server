class CreateChecks < ActiveRecord::Migration
  def change
    create_table :checks do |t|
      t.string :user_id
      t.string :cafename
      t.string :action

      t.timestamps
    end
  end
end
