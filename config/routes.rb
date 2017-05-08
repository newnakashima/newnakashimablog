Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :articles do
    resources :comments
  end

  resources :pages
  resources :users

  root 'welcome#index'

  get '/about', to: 'about#index'

  get '/hatena', to: 'articles#hatena'
  get '/callback', to: 'articles#callback'
  
  get '/login', to: 'login#index'
  post '/login', to: 'login#login'
  get '/logout', to: 'login#logout'

end
