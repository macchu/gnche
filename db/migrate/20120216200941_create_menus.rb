class CreateMenus < ActiveRecord::Migration
  def change
    create_table :menus do |t|
      t.string :title
      t.date :day
      t.string :meal
      t.integer :menu_id
      t.integer :user_id

      t.timestamps
    end
  end
end
