class AddDeletedToImages < ActiveRecord::Migration
  def change
    add_column :images, :deleted, :boolean
  end
end
