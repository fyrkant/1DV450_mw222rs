Rails.application.routes.draw do
  devise_for :users

  devise_scope :user do
    authenticated :user, lambda(&:admin?) do
      root 'admin/api_keys#index'
    end

    authenticated :user do
      root 'api_keys#index', as: :authenticated_root
    end

    unauthenticated do
      root 'pages#landing', as: :unauthenticated_root
    end
  end

  resources :api_keys

  namespace :admin do
    resources :api_keys, except: [:new, :create, :edit]
  end
end
