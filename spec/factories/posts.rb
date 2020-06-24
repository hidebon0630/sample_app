FactoryBot.define do
  factory :post do
    sequence(:title) { |n| "Post #{n}" }
    content { '投稿のテスト' }
    association :owner
    image { Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec/fixtures/sample1.png')) }
  end
end
