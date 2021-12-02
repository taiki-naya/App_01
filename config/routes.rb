Rails.application.routes.draw do
  resources :leagues do
    resources :teams do
      resources :kits
    end
  end
  resources :posts
end
