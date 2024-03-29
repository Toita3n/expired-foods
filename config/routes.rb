Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'static_pages#top'
  get '/index.html', to: 'static_pages#top'
  get '/privacy_policy', to: 'static_pages#privacy_policy'
  get '/term_of_use', to: 'static_pages#term_of_use'
  get '/guide', to: 'static_pages#guide'
  get :sign_up, to: 'users#new'
  post :sign_up, to: 'users#create'
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  post '/guest_login', to: 'guest_sessions#create'
  delete '/guest_logout', to: 'guest_sessions#destroy'
  post '/callback', to: 'line_bot#callback'
  get '/callback', to: 'oauths#callback'
  post 'oauth/callback', to: 'oauths#callback'
  get 'oauth/:provider', to: 'oauths#oauth', as: :auth_at_provider
  resources :items do
    collection do
      get 'search'
      get 'already_expired'
    end
    patch 'increment', on: :member
    patch 'decrement', on: :member
  end
  resources :users, only: %i[new create destroy]
  resource :authentication
  resource :profile, only: %i[show edit update]
  resources :shopping_lists, only: %i[index create new edit update]
  delete 'shopping_lists/destroy', to: 'shopping_lists#destroy_selected', as: :destroy_selected_shopping_lists
  resources :password_resets, only: %i[new create edit update]
  resources :inquiries, only: %i[new create] do
    get '/mentions', to: 'inquiries#mentions'
  end

  namespace :admin do
    root to: 'dashboards#index'
    get '/login', to: 'user_sessions#new'
    post '/login', to: 'user_sessions#create'
    delete '/logout', to: 'user_sessions#destroy'
    resources :users, only: %i[index edit update show destroy] do
      collection do
        get 'search'
      end
    end

    resources :items, only: %i[index edit update show destroy] do
      collection do
        get 'search'
      end
    end

    resources :shopping_lists, only: %i[index update show destroy] do
      collection do
        get 'search'
      end
    end
  end

  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?
end
