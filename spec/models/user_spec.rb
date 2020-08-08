# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  admin_flg              :boolean
#  avatar                 :string(255)
#  email                  :string(255)      default(""), not null
#  encrypted_password     :string(255)      default(""), not null
#  name                   :string(255)      default(""), not null
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string(255)
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
# Indexes
#
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#
require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'バリデーション' do
    let!(:user) { build(:user) }
    it 'ユーザーファクトリが有効' do
      expect(user).to be_valid
    end

    it '名前が無い場合は無効' do
      user.name = nil
      user.valid?
      expect(user.errors[:name]).to include('を入力してください')
    end

    it '30文字以下の名前は有効' do
      user.name = 'a' * 30
      user.valid?
      expect(user).to be_valid
    end

    it '31文字以上の名前は無効' do
      user.name = 'a' * 31
      user.valid?
      expect(user.errors[:name]).to include('は30文字以内で入力してください')
    end

    it 'アバター画像が無くても有効' do
      user.avatar = nil
      user.valid?
      expect(user).to be_valid
    end

    it 'メールアドレスが無い場合は無効' do
      user.email = nil
      user.valid?
      expect(user.errors[:email]).to include('を入力してください')
    end

    it '重複したメールアドレスは無効' do
      create(:user, email: 'tester@example.com')
      user.email = 'tester@example.com'
      user.valid?
      expect(user.errors[:email]).to include('はすでに存在します')
    end

    it 'メールアドレスは小文字に変換' do
      user.email = 'TESTER@eXAmpLe.com'
      user.valid?
      expect(user[:email]).to eq 'tester@example.com'
    end

    it '255文字以下のメールアドレスは有効' do
      user.email = 'a' * 243 + '@example.com'
      user.valid?
      expect(user).to be_valid
    end

    it '256文字以上のメールアドレスは無効' do
      user.email = 'a' * 244 + '@example.com'
      user.valid?
      expect(user.errors[:email]).to include('は255文字以内で入力してください')
    end

    it '6文字以上のパスワードは有効' do
      user.password = 'a' * 6
      user.valid?
      expect(user).to be_valid
    end

    it '5文字以下のパスワードは無効' do
      user.password = 'a' * 5
      user.valid?
      expect(user.errors[:password]).to include('は6文字以上で入力してください')
    end
  end

  describe '依存性' do
    it 'ユーザーを削除すると投稿も削除される' do
      user = create(:user, :with_posts)
      expect { user.destroy }.to change { Post.count }.by(-1)
    end

    it 'ユーザーを削除するとコメントも削除される' do
      user = create(:user, :with_comments)
      expect { user.destroy }.to change { Comment.count }.by(-1)
    end

    it 'ユーザーを削除すると項目も削除される' do
      user = create(:user, :with_options)
      expect { user.destroy }.to change { Option.count }.by(-1)
    end

    it 'ユーザーを削除すると回答も削除される' do
      user = create(:user, :with_votes)
      expect { user.destroy }.to change { Vote.count }.by(-1)
    end

    it 'ユーザーを削除するといいねも削除される' do
      user = create(:user)
      post = create(:post)
      user.like(post)
      expect(user.already_liked?(post)).to eq true
      expect { user.destroy }.to change { user.liked_posts.count }.by(-1)
    end

    it 'ユーザーを削除するとフォローも削除される' do
      user = create(:user)
      other_user = create(:user)
      user.follow(other_user)
      expect(user.following?(other_user)).to be_truthy
      expect { user.destroy }.to change { other_user.followers.count }.by(-1)
    end

    it 'ユーザーを削除するとフォロワーも削除される' do
      user = create(:user)
      other_user = create(:user)
      user.follow(other_user)
      expect(user.following?(other_user)).to be_truthy
      expect { other_user.destroy }.to change { user.following.count }.by(-1)
    end
  end
end
