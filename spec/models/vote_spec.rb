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
require 'rails_helper'

RSpec.describe Vote, type: :model do
  let!(:vote) { create(:vote) }
  it 'ユーザーがない場合、無効であること' do
    vote.user = nil
    vote.valid?
    expect(vote).to_not be_valid
  end

  it '投稿がない場合は無効' do
    vote.post = nil
    vote.valid?
    expect(vote).to_not be_valid
  end

  it '項目がない場合は無効' do
    vote.option = nil
    vote.valid?
    expect(vote).to_not be_valid
  end
end
