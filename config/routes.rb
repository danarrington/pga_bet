Rails.application.routes.draw do
  get 'tournaments/index'

  root :to => "home#index"
  devise_for :users, :controllers => {:registrations => "registrations"}

  get '/players/update_players' => 'players#update_players'
  get '/users/add_pick' => 'users#add_pick', :as => :add_pick
  post '/users/add_pick' => 'users#submit_pick'
  get '/all' => 'home#all_results'
  get '/tourney' => 'tournaments#index', as: :tourney
  post '/tourney/create' => 'tournaments#create', as: :create_tourney
  resources :users

  if Rails.env.development?
    require 'mr_video'
    mount MrVideo::Engine => '/mr_video'
  end
end
