# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# ゲストユーザー

User.create!(name: 'ゲストユーザー',
             email: 'guest@example.com',
             password: 'password',
             password_confirmation: 'password')

# ユーザー
10.times do |n|
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

# 質問
users = User.all
post_title = 'テスト投稿です'
tag_list = 'サンプル,テスト'
option_titles = %w[あいうえお かきくけこ さしすせそ にふぇいふbw jぢあふぃえ bふいbふぃわ].sample(3)
users.each do |user|
  post = user.posts.create!(title: post_title, tag_list: tag_list)
  3.times do |n|
    option_title = option_titles.fetch(n)
    post.options.create!(title: option_title, post_id: post.id, user_id: user.id)
  end
end

# 回答、コメント
posts = Post.order(:created_at).take(7)
posts.each do |post|
  users = User.order(:created_at).where.not(id: post.user_id).take(7)
  users.each do |user|
    number = rand(3)
    vote = post.votes.create(option_id: post.options[number].id, user_id: user.id)
    post.create_notification_vote!(user, vote.id)
    comment = post.comments.create(content: "テストコメントです", user_id: user.id)
    post.create_notification_comment!(user, comment.id)
  end
end

# いいね
users = User.order(:created_at).take(3)
users.each do |user|
  posts = Post.order(:created_at).where.not(user_id: user.id).take(5)
  posts.each do |post|
    user.like(post)
    post.create_notification_like!(user)
  end
end

# フォロー
users = User.all
user  = users.first
following = users[2..6]
followers = users[3..8]
following.each do |followed|
  user.follow(followed)
  followed.create_notification_follow!(user)
end
followers.each do |follower|
  follower.follow(user)
  user.create_notification_follow!(follower)
end
