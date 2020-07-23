# == Schema Information
#
# Table name: comments
#
#  id         :bigint           not null, primary key
#  content    :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  post_id    :integer
#  user_id    :integer
#
# Indexes
#
#  index_comments_on_post_id  (post_id)
#  index_comments_on_user_id  (user_id)
#
require 'rails_helper'

RSpec.describe Comment, type: :model do
  describe "バリデーション" do
    let!(:comment) { create(:comment) }
    it 'コメントファクトリが有効' do
      expect(comment).to be_valid
    end

    it 'ユーザーがない場合は無効' do
      comment.user = nil
      comment.valid?
      expect(comment).to_not be_valid
    end

    it '投稿がない場合は無効' do
      comment.post = nil
      comment.valid?
      expect(comment).to_not be_valid
    end

    it '内容が無い場合は無効' do
      comment.content = nil
      comment.valid?
      expect(comment.errors[:content]).to include('を入力してください')
    end

    it '内容が30文字以下は有効' do
      comment.content = 'a' * 30
      comment.valid?
      expect(comment).to be_valid
    end

    it '内容が31文字以上は無効' do
      comment.content = 'a' * 31
      comment.valid?
      expect(comment.errors[:content]).to include('は30文字以内で入力してください')
    end
  end
end
