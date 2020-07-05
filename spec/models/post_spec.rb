# == Schema Information
#
# Table name: posts
#
#  id         :bigint           not null, primary key
#  content    :text(65535)
#  image      :string(255)
#  title      :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :bigint
#
# Indexes
#
#  index_posts_on_user_id                 (user_id)
#  index_posts_on_user_id_and_created_at  (user_id,created_at)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
require 'rails_helper'

RSpec.describe Post, type: :model do
  before do
    @user = User.create(
      name: 'tester',
      email: 'tester@example.com',
      password: 'password',
      birth_date: Date.new(1990, 1, 1)
    )

    @post = @user.posts.build(
      content: 'test',
      title: 'test',
      image: Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec/fixtures/sample1.png'))
    )
  end

  it '投稿が有効' do
    @post.valid?
    expect(@post).to be_valid
  end

  it '画像が無い場合は無効' do
    @post.image = nil
    @post.valid?
    expect(@post.errors[:image]).to include('を入力してください')
  end

  it '内容が無い場合は無効' do
    @post.content = ''
    @post.valid?
    expect(@post.errors[:content]).to include('を入力してください')
  end

  it '内容が100文字以内場合は有効' do
    @post.content = 'a' * 100
    @post.valid?
    expect(@post).to be_valid
  end

  it '内容が101文字以上場合は無効' do
    @post.content = 'a' * 101
    @post.valid?
    expect(@post.errors[:content]).to include('は100文字以内で入力してください')
  end

  it 'タイトルが無い場合は無効' do
    @post.title = ''
    @post.valid?
    expect(@post.errors[:title]).to include('を入力してください')
  end

  it 'タイトルが15字以内の場合は有効' do
    @post.title = 'a' * 15
    @post.valid?
    expect(@post).to be_valid
  end

  it 'タイトルが16文字以上の場合は無効' do
    @post.title = 'a' * 16
    @post.valid?
    expect(@post.errors[:title]).to include('は15文字以内で入力してください')
  end

  it '投稿が新しい順に並んでいる' do
    @user.posts.create(
      content: 'test1',
      title: 'test1',
      image: Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec/fixtures/sample1.png')),
      created_at: 2.days.ago
    )

    @user.posts.create(
      content: 'test2',
      title: 'test2',
      image: Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec/fixtures/sample1.png')),
      created_at: 5.minutes.ago
    )

    most_recent_post = @user.posts.create(
      content: 'test2',
      title: 'test2',
      image: Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec/fixtures/sample1.png')),
      created_at: Time.zone.now
    )

    expect(most_recent_post).to eq Post.first
  end
end
