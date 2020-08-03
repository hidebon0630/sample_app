require 'rails_helper'

RSpec.describe 'Posts', type: :system do
  it '新規投稿' do
    user = create(:user)
    sign_in user

    visit posts_path

    expect do
      link = find('.new-post-link')
      expect(link[:href]).to eq new_post_path
      link.click
      fill_in '質問', with: '質問'
      (all('.option_titles')[0]).set('テスト回答1')
      (all('.option_titles')[1]).set('テスト回答2')
      attach_file 'post[image]', "#{Rails.root}/spec/fixtures/sample1.png"
      click_button '投稿'
    end.to change(user.posts, :count).by(1)
  end

  describe '投稿詳細' do
    it '自分の投稿の場合' do
      option = create(:option)

      sign_in option.user
      visit posts_path
      click_link href: post_votes_path(option.post)
      expect(current_path).to eq post_votes_path(option.post)
      expect(page).to have_content 'コメント一覧'
    end
    it '他人の投稿の場合' do
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
    end
  end
end
