FactoryBot.define do
  factory :like do
    association :post
    user { post.owner }
  end
end
