Rails.application.routes.draw do
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
