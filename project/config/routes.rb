Rails.application.routes.draw do
  get 'search' => 'programs#search'
  resources :programs do
    resources :discussions
    resources :relations
  end
  resources :users do
    collection do
      get 'login'
      post 'do_login'
      get 'logout'
      get 'register'
      post 'do_register'
      get 'following'
    end
    resources :relations
  end


  root :to=> 'programs#index'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
