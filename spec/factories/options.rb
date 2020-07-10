# == Schema Information
#
# Table name: options
#
#  id         :bigint           not null, primary key
#  title      :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  post_id    :bigint
#  user_id    :bigint
#
# Indexes
#
#  index_options_on_post_id  (post_id)
#  index_options_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (post_id => posts.id)
#  fk_rails_...  (user_id => users.id)
#
FactoryBot.define do
  factory :option do
    post { nil }
    title { "MyString" }
  end
end
