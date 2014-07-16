class Leaderboard

  def results_for_user(user)
    player_names = user.picks.where(tournament: Tournament.active).collect{|x| x.player.name}
    leaderboard.select{|x| player_names.include?(x.name)}.map{|x| PlayerResults.new(x)}

  end


  private
  def leaderboard
    @leaderboard ||= Golfscrape::Client.new.leaderboard
  end

end