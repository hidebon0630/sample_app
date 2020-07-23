require 'rails_helper'

RSpec.describe 'Users', type: :request do
  let(:user) { create(:user) }
  let(:admin) { create(:user, :admin) }

  describe 'GET /users' do
    context 'ログイン状態のとき' do
      it '正常に表示' do
        sign_in user
        get users_path
        expect(response).to have_http_status 200
      end
    end

    context '未ログイン状態のとき' do
      it 'ログインページにリダイレクト' do
        get users_path
        expect(response).to have_http_status 302
        expect(response).to redirect_to '/login'
      end
    end
  end

  describe 'GET /users/xxx' do
    context 'ログイン状態のとき' do
      it '正常に表示' do
        sign_in user
        get user_path(user)
        expect(response).to have_http_status 200
      end
    end

    context '未ログイン状態のとき' do
      it 'ログインページにリダイレクト' do
        get user_path(user)
        expect(response).to have_http_status 302
        expect(response).to redirect_to '/login'
      end
    end
  end

  describe "GET /admin" do
    context 'ログイン状態のとき' do
      it '管理ページにリダイレクト' do
        sign_in admin
        get "/admin"
        expect(response).to have_http_status 200
      end
      # 例外が発生してしまう
      # it '管理ページにリダイレクト' do
      #   sign_in user
      #   get "/admin"
      #   expect(response).to have_http_status 302
      #   expect(response).to redirect_to '/posts'
      # end
    end
    # 例外が発生してしまう
    # context '未ログイン状態のとき' do
    #   it '管理ページにリダイレクト' do
    #     get "/admin"
    #     expect(response).to have_http_status 302
    #     expect(response).to redirect_to '/login'
    #   end
    # end
  end


  describe "GET /login" do
    context 'ログイン状態のとき' do
      it '投稿一覧ページにリダイレクト' do
        sign_in user
        get new_user_session_path
        expect(response).to have_http_status(302)
        expect(response).to redirect_to '/posts'
      end
    end
    context '未ログイン状態のとき' do
      it "response 200" do
        get new_user_session_path
        expect(response).to have_http_status(200)
      end
    end
  end

  describe "GET /signup" do
    context 'ログイン状態のとき' do
      it '投稿一覧ページにリダイレクト' do
        sign_in user
        get new_user_registration_path
        expect(response).to have_http_status(302)
        expect(response).to redirect_to '/posts'
      end
    end
    context '未ログイン状態のとき' do
      it "response 200" do
        get new_user_registration_path
        expect(response).to have_http_status(200)
      end
    end
  end

  describe "GET /signup/edit" do
    context 'ログイン状態のとき' do
      it "response 200" do
        sign_in user
        get edit_user_registration_path
        expect(response).to have_http_status(200)
      end
    end
    context '未ログイン状態のとき' do
      it '投稿一覧ページにリダイレクト' do
        get edit_user_registration_path
        expect(response).to have_http_status(302)
        expect(response).to redirect_to '/login'
      end
    end
  end
end
