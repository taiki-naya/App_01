Rails.application.routes.draw do
  root to: 'leagues#index'
  resources :leagues do
    resources :teams do
      resources :kits
      collection {post :import}
    end
  end
  resources :posts
end
