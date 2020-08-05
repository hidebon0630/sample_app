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
20.times do |n|
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

post_titles = %w[
  好きな食べ物は？
  今日の天気は？
  現在、何を頑張っていますか？
  気分はどう？
  このアプリ使いやすい？
  今週末、何する予定？
  趣味は何ですか？
  Switch派？PS4派？
  使用してるプログラミング言語は？
  猫派？犬派？
  服装で一番気合入れるのはどれ？
  学習は頻繁にどこでする？
  健康に気を遣ってる？
  筋トレは週何回する？
  通勤時間はどのくらい？
  好きな音楽のジャンルは？
]
tag_lists = %w[
  食べ物
  天気
  モチベーション
  気分
  たんなる質問
  予定
  趣味
  ゲーム
  プログラミング
  動物
  ファッション
  勉強
  ヘルスケア
  フィットネス
  仕事
  音楽
]
option_titles = %w[
  オムライス ラーメン 寿司
  晴れ 曇り 雨
  ポートフォリオ作成 実務 プログラミング以外
  最高！ 普通 イマイチ
  ええ感じ まぁ微妙 ぶっちゃけ使いづらい
  遊びに行く 勉強 特に予定はない
  スポーツ ファッション ゲーム
  Switch PS4 スマホゲーム
  Ruby Python Go
  猫 犬 その他(詳細はコメントへ)
  服 時計 靴
  カフェ 家 仕事先だけ
  もちろん！ ちょっと運動する程度 何もしてない
  0~1回 2~4回 5回~
  0~30分 30分~1時間 1時間~
  Jpop ロック ジャズ
]
comment_contents = %w[
  気になってた質問...!
  意外な結果！
  予想通りの結果だなぁ
  もっとみんな回答してほしい！
  参考にさせてもらいます。
]

# 質問
users = User.order(:created_at).take(15)
num = 0
users.each do |user|
  post = user.posts.create!(title: post_titles[num], tag_list: tag_lists[num])
  option = option_titles.in_groups_of(3, false)
  3.times do |n|
    post.options.create!(title: option[num][n], post_id: post.id, user_id: user.id)
  end
  num += 1
end

# コメント
users = User.order(:created_at).take(5)
users.each do |user|
  posts = Post.order(:created_at).where.not(user_id: user.id).take(5)
  posts.each do |post|
    num = rand(5)
    comment = post.comments.create(content: comment_contents[num], user_id: user.id)
    post.create_notification_comment!(user, comment.id)
  end
end

# いいね
users = User.order(:created_at).take(5)
posts = Post.order(:created_at).take(3)
users.each do |user|
  posts.each do |post|
    user.like(post) unless user.id == post.user_id
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
