Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  devise_for :shoppers
  devise_for :users, controllers: {
  sessions:      'users/sessions',
  passwords:     'users/passwords',
  registrations: 'users/registrations'
}
  resources :profiles, only: [:show, :edit, :update]
  root to: 'leagues#index'
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

  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?
end
