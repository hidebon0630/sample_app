# == Schema Information
#
# Table name: options
#
#  id         :bigint           not null, primary key
#  title      :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  post_id    :integer
#  user_id    :integer
#
# Indexes
#
#  index_options_on_post_id  (post_id)
#  index_options_on_user_id  (user_id)
#
FactoryBot.define do
  factory :option do
    title { %w[あいうえお かきくけこ さしすせそ] }
    association :post
    user { post.user }

    trait :with_votes do
      transient do
        votes_count { 1 }
      end

      after(:create) do |option, evaluator|
        create_list(:vote, evaluator.votes_count, option: option)
      end
    end
  end
end
