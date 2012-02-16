class AddRecipeIdToMenus < ActiveRecord::Migration
  def change
    add_column :menus, :recipe_id, :integer
  end
end
