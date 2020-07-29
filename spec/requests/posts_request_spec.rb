require 'rails_helper'

RSpec.describe 'Posts', type: :request do
  let(:user) { create(:user) }

  describe 'GET /posts' do
    context 'ログイン状態' do
      it '正常に表示' do
        sign_in user
        get posts_path
        expect(response).to have_http_status 200
      end
    end
    context '未ログイン状態' do
      it 'ログインページにリダイレクト' do
        get posts_path
        expect(response).to have_http_status 302
        expect(response).to redirect_to '/login'
      end
    end
  end

  describe 'GET /posts/new' do
    context 'ログイン状態' do
      it '正常に表示' do
        sign_in user
        get new_post_path
        expect(response).to have_http_status 200
      end
    end
    context '未ログイン状態' do
      it 'ログインページにリダイレクト' do
        get new_post_path
        expect(response).to have_http_status 302
        expect(response).to redirect_to '/login'
      end
    end
  end

  describe 'GET /posts/xxx' do
    let!(:post) { create(:post) }
    context 'ログイン状態' do
      it '正常に表示' do
        sign_in user
        get post_path(post)
        expect(response).to have_http_status 200
      end
    end
    context '未ログイン状態' do
      it 'ログインページにリダイレクト' do
        get post_path(post)
        expect(response).to have_http_status 302
        expect(response).to redirect_to '/login'
      end
    end
  end

  describe 'GET /favorite' do
    context 'ログイン状態' do
      it '正常に表示' do
        sign_in user
        get favorite_path
        expect(response).to have_http_status 200
      end
    end
    context '未ログイン状態' do
      it 'ログインページにリダイレクト' do
        get favorite_path
        expect(response).to have_http_status 302
        expect(response).to redirect_to '/login'
      end
    end
  end

  describe 'GET /pv' do
    context 'ログイン状態' do
      it '正常に表示' do
        sign_in user
        get pv_path
        expect(response).to have_http_status 200
      end
    end
    context '未ログイン状態' do
      it 'ログインページにリダイレクト' do
        get pv_path
        expect(response).to have_http_status 302
        expect(response).to redirect_to '/login'
      end
    end
  end
end
