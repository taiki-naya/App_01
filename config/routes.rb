Rails.application.routes.draw do
  root to: 'leagues#index'
  # devise_for :shoppers
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
  resources :stores do
    resources :items
  end
  resources :posts

  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?
end
