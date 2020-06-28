require 'rails_helper'

RSpec.feature 'Comments', type: :feature do
  scenario "コメント" do
    user = FactoryBot.create(:user)
    post = FactoryBot.create(:post,
      title: "タイトル",
      content: "コメント機能のテストです。",
      owner: user,
      image: Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec/fixtures/sample1.png')) )
    comment = post.comments.create!(content: "コメント", user: post.owner)
    sign_in user
    visit root_path
    click_link href: post_path(post)
    expect(page).to have_content '投稿詳細ページ'
    expect(page).to have_content 'コメント機能のテストです。'
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
