# == Schema Information
#
# Table name: comments
#
#  id         :bigint           not null, primary key
#  content    :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  post_id    :bigint
#  user_id    :bigint
#
# Indexes
#
#  index_comments_on_post_id  (post_id)
#  index_comments_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (post_id => posts.id)
#  fk_rails_...  (user_id => users.id)
#
require 'rails_helper'

RSpec.describe Comment, type: :model do
  it 'コメントが有効' do
    user = User.create(
      name: 'tester',
      email: 'tester@example.com',
      password: 'password'
    )

    post = user.posts.create(
      content: 'test',
      title: 'test',
      image: Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec/fixtures/sample1.png'))
    )

    comment = post.comments.create(
      content: 'aiueo',
      user: user
    )

    comment.valid?
    expect(comment).to be_valid
  end
end
