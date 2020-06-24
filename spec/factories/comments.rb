FactoryBot.define do
  factory :comment do
    content { "コメントのテスト" }
    association :post
    user { post.user }
  end
end
