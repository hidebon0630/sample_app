# == Schema Information
#
# Table name: likes
#
#  id         :bigint           not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  post_id    :bigint
#  user_id    :bigint
#
# Indexes
#
#  index_likes_on_post_id  (post_id)
#  index_likes_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (post_id => posts.id)
#  fk_rails_...  (user_id => users.id)
#
require 'rails_helper'

RSpec.describe Like, type: :model do
  let(:like) { create(:like) }
  it 'Likeファクトリが有効' do
    expect(like).to be_valid
  end

  it 'ユーザーが無い場合は無効' do
    like.user = nil
    expect(like).not_to be_valid
  end

  it '投稿が無い場合は無効' do
    like.post = nil
    expect(like).not_to be_valid
  end
end
