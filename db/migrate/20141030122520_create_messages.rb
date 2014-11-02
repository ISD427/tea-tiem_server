class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.string :source_id
      t.string :target_id
      t.string :message

      t.timestamps
    end
  end
end
