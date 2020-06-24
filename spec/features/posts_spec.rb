require 'rails_helper'

RSpec.feature "Posts", type: :feature do
  scenario "user creates a new project" do
    user = FactoryBot.create(:user)
    sign_in user

    visit root_path

    expect {
      click_link "新規投稿"
      fill_in "タイトル", with: "テストタイトル"
      fill_in "内容", with: "テスト書いてます"
      attach_file 'post[image]', "#{Rails.root}/spec/fixtures/sample1.png"
      click_button "投稿"

      expect(page).to have_content "投稿が完了しました"
    }.to change(user.posts, :count).by(1)
  end
end
