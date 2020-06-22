# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  admin_flg              :boolean
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
  it '名前、メールアドレス、パスワードが有効' do
    user = User.new(
      name: 'tester',
      email: 'tester@example.com',
      password: 'password'
    )
    expect(user).to be_valid
  end

  it '名前が無い場合は無効' do
    user = User.new(name: nil)
    user.valid?
    expect(user.errors[:name]).to include('を入力してください')
  end

  it '50文字以下の名前は有効' do
    user = User.new(
      name: 'a' * 50,
      email: 'tester@example.com',
      password: 'password'
    )
    user.valid?
    expect(user).to be_valid
  end

  it '51文字以上の名前は無効' do
    user = User.new(
      name: 'a' * 51,
      email: 'tester@example.com',
      password: 'password'
    )
    user.valid?
    expect(user.errors[:name]).to include('は50文字以内で入力してください')
  end

  it 'メールアドレスが無い場合は無効' do
    user = User.new(email: nil)
    user.valid?
    expect(user.errors[:email]).to include('を入力してください')
  end

  it '重複したメールアドレスは無効' do
    User.create(
      name: 'tester',
      email: 'tester@example.com',
      password: 'password'
    )
    user = User.new(
      name: 'tester',
      email: 'tester@example.com',
      password: 'password'
    )
    user.valid?
    expect(user.errors[:email]).to include('はすでに存在します')
  end

  it 'メールアドレスは小文字に変換' do
    user = User.new(
      name: 'tester',
      email: 'TESTER@EXAMPLE.COM',
      password: 'password'
    )
    user.valid?
    expect(user[:email]).to eq 'tester@example.com'
  end

  it '255文字以下のメールアドレスは有効' do
    user = User.new(
      name: 'tester',
      email: 'a' * 243 + '@example.com',
      password: 'password'
    )
    user.valid?
    expect(user).to be_valid
  end

  it '256文字以上のメールアドレスは無効' do
    user = User.new(
      name: 'tester',
      email: 'a' * 244 + '@example.com',
      password: 'password'
    )
    user.valid?
    expect(user.errors[:email]).to include('は255文字以内で入力してください')
  end

  it '6文字以上のパスワードは有効' do
    user = User.new(
      name: 'tester',
      email: 'tester@example.com',
      password: 'a' * 6
    )
    user.valid?
    expect(user).to be_valid
  end

  it '5文字以下のパスワードは無効' do
    user = User.new(
      name: 'tester',
      email: 'tester@example.com',
      password: 'a' * 5
    )
    user.valid?
    expect(user.errors[:password]).to include('は6文字以上で入力してください')
  end
end
