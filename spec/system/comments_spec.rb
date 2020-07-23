require 'rails_helper'

RSpec.describe 'Comments', type: :system do
  scenario 'コメント' do
    user = FactoryBot.create(:user)
    post = FactoryBot.create(:post)

    sign_in user
    visit posts_path
    click_link href: post_path(post)
    expect(page).to have_button '回答'
  end
end
