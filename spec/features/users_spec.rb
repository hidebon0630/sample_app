require 'rails_helper'

RSpec.feature 'Users', type: :feature do
  scenario '新規登録' do
    visit root_path
    click_link '新規登録'
    fill_in '名前', with: 'テストユーザー'
    fill_in 'メールアドレス', with: 'aiueo@aiueo'
    fill_in 'パスワード', with: 'password'
    fill_in 'パスワード（確認用）', with: 'password'
    click_button '新規登録'
    expect(page).to have_content 'メールアドレスは不正な値です'
    fill_in '名前', with: 'テストユーザー'
    fill_in 'メールアドレス', with: 'aiueo@example.com'
    fill_in 'パスワード', with: 'password'
    fill_in 'パスワード（確認用）', with: 'aiueo'
    click_button '新規登録'
    expect(page).to have_content 'パスワード（確認用）とパスワードの入力が一致しません'
    fill_in '名前', with: 'テストユーザー'
    fill_in 'メールアドレス', with: 'tester@example.com'
    fill_in 'パスワード', with: 'password'
    fill_in 'パスワード（確認用）', with: 'password'
    click_button '新規登録'
    expect(page).to have_content 'アカウント登録が完了しました。'
  end

  scenario '通常ユーザーでログイン、ログアウト' do
    FactoryBot.create(:user, :sample)
    visit root_path
    click_link 'ログイン'
    fill_in 'メールアドレス', with: 'sample@example.com'
    fill_in 'パスワード', with: 'password'
    click_button 'ログイン'
    expect(page).to have_content 'ログインしました。'
    click_link '設定'
    expect(page).to have_button '更新'
    visit root_path
    click_link 'ログアウト'
    expect(page).to have_content 'ログアウトしました。'
  end

  scenario 'ゲストユーザーでログイン' do
    FactoryBot.create(:user, :guest)
    visit root_path
    click_link 'ログイン'
    fill_in 'メールアドレス', with: 'guest@example.com'
    fill_in 'パスワード', with: 'password'
    click_button 'ログイン'
    expect(page).to have_content 'ログインしました。'
    click_link '設定'
    expect(page).to have_content 'ゲストユーザーは変更出来ません。'
  end

  scenario 'かんたんログイン' do
    FactoryBot.create(:user, :guest)
    visit root_path
    click_link 'ログイン'
    click_button 'かんたんログイン'
    expect(page).to have_content 'ログインしました。'
    click_link '設定'
    expect(page).to have_content 'ゲストユーザーは変更出来ません。'
  end

  scenario '管理ユーザーでログイン' do
    FactoryBot.create(:user, :admin)
    visit root_path
    click_link 'ログイン'
    fill_in 'メールアドレス', with: 'admin@example.com'
    fill_in 'パスワード', with: 'password'
    click_button 'ログイン'
    expect(page).to have_content 'ログインしました。'
    visit rails_admin_path
    expect(page).to have_content 'サイト管理'
  end
end
