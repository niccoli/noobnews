NoobNews::Application.routes.draw do
  resources :posts do
    resources :comments
  end
  
  resources :users
  resources :sessions
  resources :votes

  root :to => 'posts#index'
end
