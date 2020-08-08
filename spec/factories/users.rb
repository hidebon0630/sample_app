# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  admin_flg              :boolean
#  avatar                 :string(255)
#  email                  :string(255)      default(""), not null
#  encrypted_password     :string(255)      default(""), not null
#  gender                 :integer
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
FactoryBot.define do
  factory :user do
    name { 'テストユーザー' }
    sequence(:email) { |n| "tester#{n}@example.com" }
    password { 'password' }
    avatar { Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec/fixtures/sample1.png')) }

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

    trait :with_posts do
      transient do
        posts_count { 1 }
      end

      after(:create) do |user, evaluator|
        create_list(:post, evaluator.posts_count, user: user)
      end
    end

    trait :with_comments do
      transient do
        comments_count { 1 }
      end

      after(:create) do |user, evaluator|
        create_list(:comment, evaluator.comments_count, user: user)
      end
    end

    trait :with_options do
      transient do
        options_count { 1 }
      end

      after(:create) do |user, evaluator|
        create_list(:option, evaluator.options_count, user: user)
      end
    end

    trait :with_votes do
      transient do
        votes_count { 1 }
      end

      after(:create) do |user, evaluator|
        create_list(:vote, evaluator.votes_count, user: user)
      end
    end
  end
end
