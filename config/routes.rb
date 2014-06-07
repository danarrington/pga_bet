Rails.application.routes.draw do
  root :to => "home#index"
  devise_for :users, :controllers => {:registrations => "registrations"}
  resources :users

  get '/players/update_players' => 'players#update_players'
end