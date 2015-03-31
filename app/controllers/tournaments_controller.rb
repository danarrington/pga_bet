class TournamentsController < ApplicationController
  def index
    @leaderboard = Golfscrape::Client.new.leaderboard
    @tournament = Tournament.active 
  end
end
