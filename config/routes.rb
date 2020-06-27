# frozen_string_literal: true

Rails.application.routes.draw do
  root 'posts#index'
  get '/home', to: 'static_pages#home'
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  devise_for :users,
             path: '',
             path_names: {
               sign_up: '',
               sign_in: 'login',
               sign_out: 'logout',
               registration: 'signup'
             },
             controllers: {
               registrations: 'users/registrations'
             }
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :users do
    member do
      get :following, :followers
    end
  end
  resources :posts do
    resources :likes, only: %i[create destroy]
    resources :comments, only: [:create]
    resources :questions, only: %i[create destroy]
  end
  resources :relationships, only: %i[create destroy]
  resources :notifications, only: :index
  resources :messages, only: [:create]
  resources :rooms, only: %i[create show]
end
