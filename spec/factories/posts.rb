FactoryBot.define do
  factory :post do
    title { '投稿タイトル' }
    association :user
    image { Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec/fixtures/sample1.png')) }

    trait :with_comments do
      transient do
        comments_count { 1 }
      end

      after(:create) do |post, evaluator|
        create_list(:comment, evaluator.comments_count, post: post)
      end
    end

    trait :with_options do
      transient do
        options_count { 1 }
      end

      after(:create) do |post, evaluator|
        create_list(:option, evaluator.options_count, post: post)
      end
    end

    trait :with_votes do
      transient do
        votes_count { 1 }
      end

      after(:create) do |post, evaluator|
        create_list(:vote, evaluator.votes_count, post: post)
      end
    end

    trait :with_likes do
      transient do
        likes_count { 1 }
      end

      after(:create) do |post, evaluator|
        create_list(:like, evaluator.likes_count, post: post)
      end
    end
  end
end
