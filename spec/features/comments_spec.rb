require 'rails_helper'

RSpec.feature 'Comments', type: :feature do
  scenario 'コメント' do
    user = FactoryBot.create(:user)
    post = FactoryBot.create(:post)
    post.comments.create!(content: 'コメント', user: post.owner)

    sign_in user
    visit root_path
    click_link href: post_path(post)
    expect(page).to have_content '投稿詳細'
    expect do
      fill_in '内容', with: ''
      click_button 'コメントする'
      expect(page).to have_content 'コメントに失敗しました。'
    end.to change(post.comments, :count).by(0)
    expect do
      fill_in '内容', with: 'a' * 31
      click_button 'コメントする'
      expect(page).to have_content 'コメントに失敗しました。'
    end.to change(post.comments, :count).by(0)
    expect do
      fill_in '内容', with: 'テストコメントです。'
      click_button 'コメントする'
      expect(page).to have_content 'テストコメントです。'
    end.to change(post.comments, :count).by(1)
  end
end
