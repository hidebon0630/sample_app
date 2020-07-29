require 'rails_helper'

RSpec.describe 'Comments', type: :system do
  scenario 'コメント' do
    user = create(:user)
    option = create(:option)

    sign_in user
    visit posts_path
    click_link href: post_path(option.post)
    expect(current_path).to eq post_path(option.post)
    choose 'あいうえお'
    expect(page).to have_checked_field 'あいうえお'
    click_button '回答'
    expect(current_path).to eq post_votes_path(option.post)
    expect(page).to have_content 'コメント一覧'
    fill_in 'コメント', with: 'コメント'
    click_button '送信する'
    expect(page).to have_content user.name
  end
end
