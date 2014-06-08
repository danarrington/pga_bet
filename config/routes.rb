Rails.application.routes.draw do
  root :to => "home#index"
  devise_for :users, :controllers => {:registrations => "registrations"}

  get '/players/update_players' => 'players#update_players'
  get '/users/add_pick' => 'users#add_pick', :as => :add_pick
  post '/users/add_pick' => 'users#submit_pick'
  resources :users
end