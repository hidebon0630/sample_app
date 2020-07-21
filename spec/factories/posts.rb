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
FactoryBot.define do
  factory :post do
    title { 'テストタイトル' }
    association :owner
    image { Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec/fixtures/sample1.png')) }
  end
end
