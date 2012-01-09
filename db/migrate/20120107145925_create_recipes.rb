class CreateRecipes < ActiveRecord::Migration
  def change
    create_table :recipes do |t|
      t.string :title
      t.string :url
      t.string :image
      t.datetime :dateAdded
      t.integer :addedBy

      t.timestamps
    end
  end
end
