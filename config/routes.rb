# frozen_string_literal: true

Rails.application.routes.draw do
  root 'static_pages#home'
  get '/favorite', to: 'posts#favorite'
  get '/pv', to: 'posts#pv'
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
    resource :relationships, only: %i[create destroy]
  end
  resources :posts do
    resource :likes, only: %i[create destroy]
    resources :comments, only: :create
    resource :votes, only: %i[show create]
  end
  resources :notifications, only: :index
  resources :messages, only: :create
  resources :rooms, only: %i[create show]
end
