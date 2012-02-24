# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

menu_temp = Menu_Item.create([{ menu_id: 0}, { recipe_id: 1}])
menu_temp = Menu_Item.create([{ menu_id: 0}, { recipe_id: 2}])
menu_temp = Menu_Item.create([{ menu_id: 1}, { recipe_id: 1}])
menu_temp = Menu_Item.create([{ menu_id: 1}, { recipe_id: 2}])
menu_temp = Menu_Item.create([{ menu_id: 2}, { recipe_id: 1}])
menu_temp = Menu_Item.create([{ menu_id: 2}, { recipe_id: 2}])
