class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users, id: false do |t|
      t.string :id, null: false
      t.string :username

      t.timestamps
    end
    add_index :users, :id, unique: true
  end
end
