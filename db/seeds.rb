# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
User.create!(name: 'ゲストユーザー',
             email: 'guest@example.com',
             password: 'password',
             password_confirmation: 'password')

30.times do |n|
  name = Faker::Name.name
  email = "sample-#{n + 1}@example.com"
  avatar = "#{Rails.root}/db/fixtures/sample1.png"
  password = 'password'
  User.create!(name: name,
               email: email,
               avatar: File.open(avatar),
               password: password,
               password_confirmation: password)
end

users = User.order(:created_at).take(6)
10.times do
  title = Faker::Lorem.sentence(word_count: 3)
  image = "#{Rails.root}/db/fixtures/sample1.png"
  users.each { |user| user.posts.create!(title: title, image: File.open(image)) }
end

users = User.all
user  = users.first
following = users[1..20]
followers = users[1..20]
following.each { |followed| user.follow(followed) }
followers.each { |follower| follower.follow(user) }
