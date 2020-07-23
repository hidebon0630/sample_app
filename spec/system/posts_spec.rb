require 'rails_helper'

RSpec.describe 'Posts', type: :system do
  scenario '新規投稿' do
    user = create(:user, :sample)
    sign_in user

    visit posts_path

    # expect do
    link = find('.new-post-link')
    expect(link[:href]).to eq new_post_path
    link.click
    fill_in '質問', with: '質問'
    attach_file 'post[image]', "#{Rails.root}/spec/fixtures/sample1.png"
    # click_button '回答'

    # expect(page).to have_content '投稿が完了しました'
    # end.to change(user.posts, :count).by(1)
  end

  scenario '投稿詳細' do
    user = create(:user, :sample)
    post = create(:post, user: user)
    sign_in user
    visit post_path(post)
  end
end
