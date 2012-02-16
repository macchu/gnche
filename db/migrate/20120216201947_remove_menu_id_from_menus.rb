class RemoveMenuIdFromMenus < ActiveRecord::Migration
  def up
    remove_column :menus, :menu_id
  end

  def down
    add_column :menus, :menu_id, :integer
  end
end
