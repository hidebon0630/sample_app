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
    expect(page).to have_content '回答者数'
    #expect do
    #  fill_in 'コメント', with: 'コメント'
    #  click_button '送信する'
    #end.to change(user.comments :count).by(1)
  end
end
