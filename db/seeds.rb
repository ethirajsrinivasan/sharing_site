# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

user1 = User.create(email:"user1@gmail.com",password:"user1@2019",username: "user1")
user2 = User.create(email:"user2@gmail.com",password:"user2@2019",username: "user2")
user3 = User.create(email:"user3@gmail.com",password:"user3@2019",username: "user3")
user4 = User.create(email:"user4@gmail.com",password:"user4@2019",username: "user4")
user5 = User.create(email:"user5@gmail.com",password:"user5@2019",username: "user5")

location1 = Location.create(latitude: 60,longitude: 45,user:user1,public_site: true)
location2 = Location.create(latitude: 50,longitude: 85,user:user1,public_site: false)
location3 = Location.create(latitude: 70,longitude: 75,user:user2,public_site: true)
location4 = Location.create(latitude: 80,longitude: 65,user:user2,public_site: false)
location5 = Location.create(latitude: 40,longitude: 55,user:user3,public_site: false)

location2.shared_users = [user2,user3]
location4.shared_users = [user3,user4]
location5.shared_users = [user4,user5]
