Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'static_pages#top'
  get 'sessions/new'
  get :sign_up, to: 'users#new'
  post :sign_up, to: 'users#create'
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  resources :items do
    collection do
      get 'search'
    end
  end
  resources :users, only: %i[new create show edit update destroy]
  resources :tags, only: %i[index show destroy]
  resources :shopping_lists
  resources :password_resets, only: %i[new create edit update]

  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?
end
