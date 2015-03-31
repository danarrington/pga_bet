Rails.application.routes.draw do
  get 'tournaments/index'

  root :to => "home#index"
  devise_for :users, :controllers => {:registrations => "registrations"}

  get '/players/update_players' => 'players#update_players'
  get '/users/add_pick' => 'users#add_pick', :as => :add_pick
  post '/users/add_pick' => 'users#submit_pick'
  get '/all' => 'home#all_results'
  get '/tourney' => 'tournaments#index', as: :tourney_path
  resources :users
end
