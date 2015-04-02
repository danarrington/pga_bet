class TournamentsController < ApplicationController
  def index
    @leaderboard = Golfscrape::Client.new.leaderboard
    @tournament = Tournament.active 
  end

  def create
    #TODO: refactor this into Golfscrape
    @leaderboard = Golfscrape::Client.new.leaderboard
    tournament_details = @leaderboard.tournament
    name_and_date = get_name_and_date(tournament_details.name)

    @tournament = Tournament.create(name:name_and_date[:name],
                      start: name_and_date[:start_date],
                      course_par: tournament_details.par)
    @players = PlayersUpdater.update_players
    render :index
  end


  private

  def get_name_and_date(tournament_description)
    tokens = tournament_description.match(/([\w\s]*)\((\w{3}\s\d*)/i).captures
    {
      name: tokens[0].strip,
      start_date: Date.strptime(tokens[1], '%b %d')
    }
  end
end
