require 'test_helper'

class RecipeTest < ActiveSupport::TestCase
   @recipe
   
   #Edge conditions.
   test "1: Menus is empty?" do
		assert_equal(Menu.all.size, 0)
   end
   
   test "2: Recipes is empty?" do
		assert_equal(Recipe.all.size, 0)
   end
   
   test "3: add recipe1" do
		@recipe = Recipe.new
		@recipe.title = "recipe1"
		@recipe.url = "www.foodblog.com/recipe1.html"
		@recipe.image = "www.foodblog.com/recipe1.jpg"
		@recipe.addedBy = 1
		@recipe.created_at = DateTime.now
		@recipe.updated_at = DateTime.now
		@recipe.save
		assert_equal(Recipe.first.title, "recipe1")
   end
   
   test "4: add menu1" do
		@menu = Menu.new
		@menu.title = "menu1"
		@menu.meal = "lunch"
		@menu.date_of_meal = Date.today
		@menu.date_created = DateTime.now
		@menu.date_updated = DateTime.now
		@menu.user_id = 1
		@menu.save
		assert_equal(Menu.first.title, "menu1")
		puts Menu.first.title
	
   end
   
   #Association tests
   test "5: add menu_item" do
		@menu_item = MenuItem.new
		@menu_item.recipe_id = 1
		@menu_item.menu_id = 1
		@menu_item.created_at = DateTime.now
		@menu_item.updated_at = DateTime.now
		assert @menu_item.save
		
   end
   
   test "6: access recipe1 from menu1" do
		@menu = Menu.all
		puts @menu.size
		assert_equal(@menu.size, 1)
   	
   end
   
   test "access recipe from menu" do 
   	assert true
   end
   
   test "delete menu" do
   	assert true
   end
   
   test "recipe from menu still exist" do
   	assert true
   end
   
   test "re-add recipe" do
   	assert true
   end
   
   test "access recipe from menu 2" do
   	assert true
   end 
   
   test "access menu from recipe 2" do
   	assert true
   end
   
   test "delete recipe" do
   	assert true
   end
   
   test "menu still exist" do
   	assert true
   end
   
end
