class AddDeletedToMessages < ActiveRecord::Migration
  def change
    add_column :messages, :deleted, :boolean
  end
end
