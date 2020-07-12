require 'rails_helper'

RSpec.feature 'Comments', type: :feature do
  scenario 'コメント' do
    user = FactoryBot.create(:user)
    post = FactoryBot.create(:post)

    sign_in user
    visit posts_path
    click_link href: post_path(post)
    expect(page).to have_content '投稿詳細'
  end
end
