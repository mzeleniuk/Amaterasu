Amaterasu::Application.routes.draw do
  scope '(:locale)' do
    get 'admin/index'

    resources :users do
      member do
        get :following, :followers
      end
    end

    resources :account_activations, only: [:edit]
    resources :password_resets, only: [:new, :create, :edit, :update]
    resources :sessions, only: [:new, :create, :destroy]
    resources :relationships, only: [:create, :destroy]

    resources :microposts, only: [:create, :destroy] do
      resources :comments, only: [:create, :destroy]
    end

    match '/signup', to: 'users#new', via: 'get'
    match '/signin', to: 'sessions#new', via: 'get'
    post 'signin' => 'sessions#create'
    match '/signout', to: 'sessions#destroy', via: 'delete'
    match '/help', to: 'static_pages#help', via: 'get'
    match '/about', to: 'static_pages#about', via: 'get'
    match '/contact', to: 'static_pages#contact', via: 'get'

    get 'password_resets/new'
    get 'password_resets/edit'

    root to: 'static_pages#home', via: :all
  end
end
