require 'rails_helper'

RSpec.feature 'Posts', type: :feature do
  scenario '新規投稿' do
    user = FactoryBot.create(:user, :sample)
    sign_in user

    visit posts_path

    expect do
      click_link '新規投稿'
      fill_in 'タイトル', with: 'テストタイトル'
      fill_in '内容', with: 'テスト書いてます'
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
    expect(page).to have_content '投稿詳細'
  end
end
