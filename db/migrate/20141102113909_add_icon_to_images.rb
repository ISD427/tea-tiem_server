class AddIconToImages < ActiveRecord::Migration
  def change
    add_column :images, :icon, :boolean
  end
end
