Rails.application.routes.draw do
  resources :hoppers do
    resources :tasks do
      post "finish"
    end
  end

  post "users/close_greeting", to: "users#close_greeting", as: :close_greeting

  post 'hoppers/:id/start', to: "hoppers#start", as: :hopper_start
  post 'hoppers/:id/do_other', to: "hoppers#do_other", as: :hopper_do_other
  post "hoppers/:id/unpin", to: "hoppers#unpin", as: :hopper_unpin
  post "hoppers/:id/pin", to: "hoppers#pin", as: :hopper_pin
  get "hoppers/:id/export", to: "hoppers#export", as: :hopper_export

  authenticated :user do
      root :to => 'hoppers#index', as: :authenticated_root
  end
  root :to => 'welcome#index'

  devise_for :users
end
