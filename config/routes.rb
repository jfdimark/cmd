Cmd::Application.routes.draw do
  authenticated :user do
    root :to => 'users#show'
  end
  devise_for :users, controllers: {omniauth_callbacks: "omniauth_callbacks"}
  resources :users
  root :to => "home#index"

end