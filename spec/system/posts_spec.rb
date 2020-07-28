require 'rails_helper'

RSpec.describe 'Posts', type: :system do
  scenario '新規投稿' do
    user = create(:user)
    sign_in user

    visit posts_path

    expect do
      link = find('.new-post-link')
      expect(link[:href]).to eq new_post_path
      link.click
      fill_in '質問', with: '質問'
      fill_in '回答項目', with: 'あいうえお'
      attach_file 'post[image]', "#{Rails.root}/spec/fixtures/sample1.png"
      click_button '投稿'
    end.to change(user.posts, :count).by(1)
  end

  scenario '投稿詳細' do
    post = create(:post)

    sign_in post.user
    visit posts_path
    expect(current_path).to eq posts_path
    click_link href: post_path(post)
    expect(current_path).to eq posts_path

    #other_user = create(:user)
    #post = create(:post)
#
    #sign_in user
    #visit posts_path
    #click_link href: post_path(post)
    #expect(current_path).to eq post_path(post)
    #click_button '回答'
  end
end
