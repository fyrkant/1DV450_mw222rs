Rails.application.routes.draw do
  namespace :api do
    namespace :v1, path: "/" do
      resources :places
      resources :events
      resources :tags do
        resources :events, only: :index
      end
    end
  end

  devise_for :users

  devise_scope :user do
    authenticated :user, lambda(&:admin?) do
      get "api_keys", to: redirect("admin/api_keys")
      root 'admin/api_keys#index'
    end

    authenticated :user do
      root 'api_keys#index', as: :authenticated_root
    end

    unauthenticated do
      root 'pages#landing', as: :unauthenticated_root
    end
  end

  resources :api_keys, except: :show

  namespace :admin do
    resources :api_keys, except: [:new, :show, :create, :edit]

    get "search", to: "api_keys#search"
  end
end
