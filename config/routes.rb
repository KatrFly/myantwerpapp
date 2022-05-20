Rails.application.routes.draw do
  root "uncategorized_pages#home"
  devise_for :users, :controllers => { registrations: 'registrations' }
  
  get '/404', to: 'errors#not_found'
  get '/500', to: 'errors#internal_server'
  get '/422', to: 'errors#unprocessable'

  get "home", to: 'uncategorized_pages#home'
  get "about", to: 'uncategorized_pages#about'
  get "contact", to: 'uncategorized_pages#contact'

  get "posts/guides", to: 'posts#guides'
  get "posts/reviews", to: "posts#reviews"
  get "posts/interviews", to: "posts#interviews"
  get "posts/food", to: "posts#food"
  
  resources :posts, :except => [:index]
  resources :comments
  resources :saved_posts, :only => [:index, :create, :destroy]
  resources :tags, :only => [:show]


  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
