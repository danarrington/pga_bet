class PlayersController < ApplicationController
  def update_players
    client = Golfscrape::Client.new
    leaderboard = client.leaderboard

    leaderboard.each do |result|
      existing_player = Player.where(name: result.name)
      Player.create(name: result.name) unless existing_player.any?
    end

    render text: "There are now #{Player.count} players"
  end
end
