# == Schema Information
#
# Table name: posts
#
#  id                :bigint           not null, primary key
#  image             :string(255)
#  impressions_count :integer          default(0)
#  title             :string(255)
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  user_id           :integer
#
# Indexes
#
#  index_posts_on_user_id                 (user_id)
#  index_posts_on_user_id_and_created_at  (user_id,created_at)
#
require 'rails_helper'

RSpec.describe Post, type: :model do
  describe 'バリデーション' do
    let!(:post) { create(:post) }

    it '投稿ファクトリが有効' do
      expect(post).to be_valid
    end

    it 'ユーザーがない場合は無効' do
      post.user = nil
      post.valid?
      expect(post).to_not be_valid
    end

    it '画像が無い場合でも有効' do
      post.image = nil
      post.valid?
      expect(post).to be_valid
    end

    it 'タグが無い場合でも有効' do
      post.tag_list = nil
      post.valid?
      expect(post).to be_valid
    end

    it 'タイトルが無い場合は無効' do
      post.title = nil
      post.valid?
      expect(post.errors[:title]).to include('を入力してください')
    end

    it 'タイトルが30字以内の場合は有効' do
      post.title = 'a' * 30
      post.valid?
      expect(post).to be_valid
    end

    it 'タイトルが31文字以上の場合は無効' do
      post.title = 'a' * 31
      post.valid?
      expect(post.errors[:title]).to include('は30文字以内で入力してください')
    end
  end

  describe '依存性' do
    it '投稿を削除するとコメントも削除される' do
      post = create(:post, :with_comments)
      expect { post.destroy }.to change { Comment.count }.by(-1)
    end

    it '投稿を削除すると項目も削除される' do
      post = create(:post, :with_options)
      expect { post.destroy }.to change { Option.count }.by(-1)
    end

    it '投稿を削除すると回答も削除される' do
      post = create(:post, :with_votes)
      expect { post.destroy }.to change { Vote.count }.by(-1)
    end

    it '投稿を削除するといいねも削除される' do
      post = create(:post, :with_likes)
      expect { post.destroy }.to change { Like.count }.by(-1)
    end
  end
end
