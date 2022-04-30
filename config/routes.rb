Rails.application.routes.draw do
  get 'login/index'
  resources :usuarios
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  get '/login', to: 'login#index'
  post '/login', to: 'login#logar'
  get '/logout', to: 'login#logout'

  get '/search', to: 'search#show'
  post '/search', to: 'search#create'

end
