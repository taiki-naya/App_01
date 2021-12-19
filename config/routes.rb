Rails.application.routes.draw do

  root to: 'tops#index'
  get 'overview', to: 'tops#overview'

  # devise_for :shoppers

  devise_scope :user do
    post 'users/guest_sign_in', to: 'users/sessions#guest_user_sign_in'
  end
  devise_for :users, controllers: {
    sessions:      'users/sessions',
    passwords:     'users/passwords',
    registrations: 'users/registrations'
  }
  resources :profiles, only: [:show, :edit, :update]
  resources :favorites, only: [:create, :destroy]

  resources :leagues do
    resources :teams do
      resources :kits
      collection {post :import}
    end
  end

  get 'items', to: 'items#index_all'
  resources :stores do
    resources :items
  end

  resources :posts

  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?
end
