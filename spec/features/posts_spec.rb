require 'rails_helper'

RSpec.feature 'Posts', type: :feature do
  scenario '新規投稿' do
    user = FactoryBot.create(:user, :sample)
    sign_in user

    visit posts_path

    expect do
      link = find('.new-post-btn')
      expect(link[:href]).to eq new_post_path
      link.click
      fill_in 'タイトル', with: 'テストタイトル'
      attach_file 'post[image]', "#{Rails.root}/spec/fixtures/sample1.png"
      click_button '投稿'

      expect(page).to have_content '投稿が完了しました'
    end.to change(user.posts, :count).by(1)
  end

  scenario '投稿詳細' do
    user = FactoryBot.create(:user, :sample)
    post = FactoryBot.create(:post, owner: user)
    sign_in user
    visit post_path(post)
    expect(page).to have_button '回答'
  end
end
