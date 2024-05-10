Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")


  root "welcome#index"
  get '/register', to: 'users#new', as: 'register_user'

  # get 'users/:id/discover', to: 'users#discover'

  # get '/users/:id/movies', to: 'users#movies'

  resources :users, only: [:show, :create] do
    get 'discover', on: :member
    resources :movies, only: [:index, :show] do
      resources :viewing_party, only: [:new, :create]
    # get 'movies', only: :member
    end
  end
end
