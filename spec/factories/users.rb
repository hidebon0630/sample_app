# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  admin_flg              :boolean
#  avatar                 :string(255)
#  birth_date             :date             not null
#  email                  :string(255)      default(""), not null
#  encrypted_password     :string(255)      default(""), not null
#  name                   :string(255)      default(""), not null
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string(255)
#  sex                    :integer          default("sex_not_known")
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
# Indexes
#
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#
FactoryBot.define do
  factory :user, aliases: [:owner] do
    name { 'テストユーザー' }
    sequence(:email) { |n| "tester#{n}@example.com" }
    password { 'password' }

    trait :sample do
      name { 'サンプルユーザー' }
      email { 'sample@example.com' }
    end

    trait :guest do
      name { 'ゲストユーザー' }
      email { 'guest@example.com' }
    end

    trait :admin do
      name { '管理人' }
      email { 'admin@example.com' }
      admin_flg { 'true' }
    end
  end
end
