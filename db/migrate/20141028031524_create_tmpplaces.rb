class CreateTmpplaces < ActiveRecord::Migration
  def change
    create_table :tmpplaces do |t|
      t.string :user_id
      t.string :cafename

      t.timestamps
    end
  end
end
