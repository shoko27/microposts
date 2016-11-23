# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


puts "create Users ..."
(1..20).each do |i|
  User.create!(name: "test#{i}", email: "test#{i}@test.com" , password: "test")
end

# Micropost
puts "create Microposts ..."
users = User.order(:id).take(6)
(1..11).each do |i|
  content = "Hello world #{i}"
  users.each { |user| user.microposts.create!(content: content) }
end

# follow
puts "follow Users ..."
users = User.all
user  = users.first
following = users[1..9]
followers = users[10..19]
following.each { |followed| user.follow(followed) }
followers.each { |follower| follower.follow(user) }
