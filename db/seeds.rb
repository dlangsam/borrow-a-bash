# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.create!(username: "User2", email: "user2@test.com", password: "password",
	password_confirmation: "password", zip_code: "33145" )
User.create!(username: "User3", email: "user3@test.com", password: "password",
	password_confirmation: "password", zip_code: "33100" )
User.create!(username: "User4", email: "user4@test.com", password: "password",
	password_confirmation: "password", zip_code: "07078" )
User.create!(username: "User5", email: "user5@test.com", password: "password",
	password_confirmation: "password", zip_code: "07041" )
User.create!(username: "User6", email: "user6@test.com", password: "password",
	password_confirmation: "password", zip_code: "63108" )
User.create!(username: "User7", email: "user7@test.com", password: "password",
	password_confirmation: "password", zip_code: "63109" )
User.create!(username: "User8", email: "user8@test.com", password: "password",
	password_confirmation: "password", zip_code: "63130" )