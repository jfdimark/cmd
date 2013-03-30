Cmd::Application.routes.draw do
  authenticated :user do
    root :to => 'home#index'
  end
  devise_for :users, controllers: {omniauth_callbacks: "omniauth_callbacks"}
  resources :users
  root :to => "home#index"

end