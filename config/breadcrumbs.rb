crumb :root do
  link 'ホーム', posts_path
end

crumb :users do
  link '全てのユーザー', users_path
end

crumb :post_show do
  link '投稿詳細', post_path
end

crumb :user_show do
  link 'ユーザー詳細', user_path
end
