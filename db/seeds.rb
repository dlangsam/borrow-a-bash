# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# User.create!(username: "User2", email: "user2@test.com", password: "password",
# 	password_confirmation: "password", zip_code: "33145" )
# User.create!(username: "User3", email: "user3@test.com", password: "password",
# 	password_confirmation: "password", zip_code: "33100" )
# User.create!(username: "User4", email: "user4@test.com", password: "password",
# 	password_confirmation: "password", zip_code: "07078" )
# User.create!(username: "User5", email: "user5@test.com", password: "password",
# 	password_confirmation: "password", zip_code: "07041" )
# User.create!(username: "User6", email: "user6@test.com", password: "password",
# 	password_confirmation: "password", zip_code: "63108" )
# User.create!(username: "User7", email: "user7@test.com", password: "password",
# 	password_confirmation: "password", zip_code: "63109" )
# User.create!(username: "User8", email: "user8@test.com", password: "password",
# 	password_confirmation: "password", zip_code: "63130" )

furniture = Category.find_or_create_by(name: "Furniture")
entertainment = Category.find_or_create_by(name: "Entertainment")
decorations = Category.find_or_create_by(name: "Decorations")
food = Category.find_or_create_by(name: "Food & Drink")
electronics = Category.find_or_create_by(name: "Electronics")
kids = Category.find_or_create_by(name: "Kids")



user1 = User.find_or_create_by(username: "BugsBunny", email: "user200@test.com", address1: "3305 Coral Way", zip_code: "33145" )
user2= User.find_or_create_by(username: "KevinBacon", email: "user2002@test.com", zip_code: "33145" )
user3 = User.find_or_create_by(username: "HarryPotter", email: "user2003@test.com", address1: "2405 27th Ave", zip_code: "33145" )
user4= User.find_or_create_by(username: "EmmaStone", email: "user2004@test.com", address1: "49 SW 11th St", zip_code: "33130" )
user5 =User.find_or_create_by(username: "MickeyMouse", email: "user2005@test.com",  zip_code: "33130" )
user6= User.find_or_create_by(username: "SpongeBob", email: "user2006@test.com",  address1: " 2300 NW 2nd Ave",  zip_code: "33127" )
user7= User.find_or_create_by(username: "Chewbacca", email: "user2007@test.com", zip_code: "33127" )


item1 = Item.find_or_create_by(name: "Folding chairs", 
	description: "I have 10 of them. Very light and easy to transport")
item1.categories.push(furniture)
user1.items.push(item1)
item2= Item.find_or_create_by(name: "Folding chairs", 
	description: "I have 12 of them. Very light and easy to transport")
item2.categories.push(furniture)
user2.items.push(item2)
item3 = Item.find_or_create_by(name: "Cupcake tray", 
	description: "White porcelein. 3 Tiers. Holds two dozen cupcakes.")
item3.categories.push(food)
user3.items.push(item3)
item4 = Item.find_or_create_by(name: "Welcome Home Banner", 
	description: "In red white and blue. Made of plastic.")
item4.categories.push(decorations)
user4.items.push(item4)
item5 = Item.find_or_create_by(name: "It's a boy banner", 
	description: "In light blue. Made of plastic.")
item5.categories.push(decorations)
item5.categories.push(kids)
user5.items.push(item5)
item6 = Item.find_or_create_by(name: "It's a girl banner", 
	description: "In light pink. Made of felt.")
item6.categories.push(decorations)
item6.categories.push(kids)
user6.items.push(item6)
item7 = Item.find_or_create_by(name: "Happy Birthday banner", 
	description: "Rainbow colors. Plastic. 3 feet long.")
item7.categories.push(decorations)
user6.items.push(item7)
item8 = Item.find_or_create_by(name: "Punch bowl", 
	description: "Crystal glass. Holds 3+ liters. I have a dozen glasses that come with it.",
	deposit: 25.00, price: 5.00
	)
item8.categories.push(food)
user6.items.push(item8)
item9 = Item.find_or_create_by(name: "Mini Juke Box", 
	description: "Plays 50 different songs. Requires a nickel to play a song.",
	deposit: 20.00, price: 10.00
	)
item9.categories.push(electronics)
item9.categories.push(entertainment)
user4.items.push(item9)
item10= Item.find_or_create_by(name: "Projector", 
	description: 'Good for 50" to 200" screens. Comes with HDMI cord',
	deposit: 50.00, price: 10.00
	)
item10.categories.push(electronics)
item10.categories.push(entertainment)
user5.items.push(item10)
item11= Item.find_or_create_by(name: "Folding table", 
	description: 'Folding card table. Sits 4.',
	deposit: 5.00, price: 5.00
	)
item11.categories.push(furniture)
user7.items.push(item11)
item12= Item.find_or_create_by(name: "Folding table", 
	description: 'Folding table. Good for a buffet. I have a yellow table cloth that goes with it. Can sit 10 people.',
	deposit: 5.00, price: 7.00
	)
item12.categories.push(furniture)
user4.items.push(item12)
item13 = Item.find_or_create_by(name: "Old fashioned popcorn machine", 
	description: 'Vintage. Makes 10 cups of popcorn per batch.',
	deposit: 15.00, price: 10.00
	)
item13.categories.push(food)
item13.categories.push(decorations)
user5.items.push(item13)

