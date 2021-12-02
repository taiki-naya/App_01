Rails.application.routes.draw do
  resources :leagues do
    resources :teams do
      resources :kits
      collection {post :import}
    end
  end
  resources :posts
end
