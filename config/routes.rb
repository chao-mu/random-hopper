Rails.application.routes.draw do
  resources :hoppers do
    resources :tasks do
      post "finish"
    end
  end

  post 'hoppers/:id/start', to: "hoppers#start", as: :hopper_start
  post 'hoppers/:id/do_other', to: "hoppers#do_other", as: :hopper_do_other
  post "hoppers/:id/unpin", to: "hoppers#unpin", as: :hopper_unpin
  post "hoppers/:id/pin", to: "hoppers#pin", as: :hopper_pin

  authenticated :user do
      root :to => 'hoppers#index', as: :authenticated_root
  end
  root :to => 'welcome#index'

  devise_for :users
end
