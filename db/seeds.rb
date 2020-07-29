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
             password_confirmation: 'password',
             admin_flg: true)

3.times do |n|
  name = Faker::Name.name
  email = "sample-#{n + 1}@example.com"
  avatar = "#{Rails.root}/db/fixtures/avatar.jpeg"
  password = 'password'
  User.create!(name: name,
               email: email,
               avatar: File.open(avatar),
               password: password,
               password_confirmation: password)
end

users = User.all
user  = users.first
following = users[1..3]
followers = users[1..3]
following.each { |followed| user.follow(followed) }
followers.each { |follower| follower.follow(user) }
