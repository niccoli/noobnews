NoobNews::Application.routes.draw do
  resources :posts do
    resources :comments
  end
  
  resources :users
  resources :sessions
  resources :votes
  resources :static_pages
  resources :comments

  root :to => 'static_pages#index'
end
