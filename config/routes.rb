Rails.application.routes.draw do
  resources :hoppers do
    resources :tasks
  end

  post 'hoppers/:id/pop', to: "hoppers#pop", as: :hopper_pop

  post "tasks/:id/unpin", to: "tasks#unpin", as: :task_unpin

  authenticated :user do
      root :to => 'hoppers#index', as: :authenticated_root
  end
  root :to => 'welcome#index'

  devise_for :users
end
