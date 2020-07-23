# == Schema Information
#
# Table name: votes
#
#  id         :bigint           not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  option_id  :integer
#  post_id    :integer
#  user_id    :integer
#
# Indexes
#
#  index_votes_on_option_id            (option_id)
#  index_votes_on_post_id              (post_id)
#  index_votes_on_user_id              (user_id)
#  index_votes_on_user_id_and_post_id  (user_id,post_id) UNIQUE
#
FactoryBot.define do
  factory :vote do
    association :option
    post { option.post }
    user { post.user }
  end
end
