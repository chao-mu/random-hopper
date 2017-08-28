Rails.application.routes.draw do
  resources :things do
    post 'unpin'
  end

  resources :hoppers do 
    post 'pop'
  end

  authenticated :user do
      root :to => 'home#index', as: :authenticated_root
  end
  root :to => 'welcome#index'

  devise_for :users
end
