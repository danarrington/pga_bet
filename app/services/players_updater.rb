class PlayersUpdater

  def self.update_players
    leaderboard = Golfscrape::Client.new.leaderboard.results

    Player.update_all(active: false)
    
    new = 0
    updated = 0
    leaderboard.each do |result|
      existing_player = Player.where(name: result.name).first
      if existing_player
        updated += 1 
        existing_player.update_attribute(:active, true)
      else
        new += 1
        Player.create(name: result.name, active: true)
      end
    end
    {
      new:new,
      updated: updated
    }
  end
end
