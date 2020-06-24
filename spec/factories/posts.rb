FactoryBot.define do
  factory :post do
    sequence(:title) { |n| "Post #{n}" }
    content { "投稿のテスト" }
    association :user
  end
end
