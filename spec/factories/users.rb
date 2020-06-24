FactoryBot.define do
  factory :user, aliases: [:owner] do
    name { 'tester' }
    sequence(:email) { |n| "tester#{n}@example.com" }
    password { 'password' }
  end

  trait :invalid do
    name { '' }
    email { 'test@miss' }
    password { 'miss' }
  end

  trait :admin do
    name { '管理人' }
    email { 'admin@example.com' }
    password { 'password' }
    admin_flg { true }
  end

  trait :guest do
    name { 'ゲストユーザー' }
    email { 'guest@example.com' }
    password { 'password' }
  end
end
