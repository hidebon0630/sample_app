# == Schema Information
#
# Table name: posts
#
#  id                :bigint           not null, primary key
#  image             :string(255)
#  impressions_count :integer          default(0)
#  status            :integer          default("published"), not null
#  title             :string(255)
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  user_id           :bigint
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
      password: 'password'
    )

    @post = @user.posts.build(
      title: 'test',
      image: Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec/fixtures/sample1.png'))
    )
  end

  it '投稿が有効' do
    @post.valid?
    expect(@post).to be_valid
  end

  it '画像が無い場合でも有効' do
    @post.image = nil
    @post.valid?
    expect(@post).to be_valid
  end

  it 'タイトルが無い場合は無効' do
    @post.title = ''
    @post.valid?
    expect(@post.errors[:title]).to include('を入力してください')
  end

  it 'タイトルが30字以内の場合は有効' do
    @post.title = 'a' * 30
    @post.valid?
    expect(@post).to be_valid
  end

  it 'タイトルが31文字以上の場合は無効' do
    @post.title = 'a' * 31
    @post.valid?
    expect(@post.errors[:title]).to include('は30文字以内で入力してください')
  end
end
