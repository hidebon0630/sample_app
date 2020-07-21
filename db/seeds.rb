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

3.times do |n|
  name = Faker::Name.name
  email = "sample-#{n + 1}@example.com"
  avatar = "#{Rails.root}/db/fixtures/avatar.png"
  password = 'password'
  User.create!(name: name,
               email: email,
               avatar: File.open(avatar),
               password: password,
               password_confirmation: password)
end

users = User.order(:created_at).take(3)
post_title = 'アンケートタイトル'
image = "#{Rails.root}/db/fixtures/sample1.png"
tag_list = 'サンプル,テスト'
option_titles = %w[あいうえお かきくけこ さしすせそ にふぇいふbw jぢあふぃえ bふいbふぃわ]
option_title = option_titles.sample(3)
users.each do |user|
  post = user.posts.create!(title: post_title, image: File.open(image), tag_list: tag_list)
  3.times do |n|
    option = option_title.fetch(n)
    post.options.create!(title: option, post_id: post.id, user_id: user.id)
  end
end

users = User.all
user  = users.first
following = users[1..3]
followers = users[1..3]
following.each { |followed| user.follow(followed) }
followers.each { |follower| follower.follow(user) }
