class Leaderboard

  def results_for_user(user)
    player_names = user.players.collect(&:name)
    @leaderboard.select{|x| player_names.include?(x.name)}.map{|x| PlayerResults.new(x)}

  end


  private
  def leaderboard
    @leaderboard ||= Golfscrape::Client.new.leaderboard
  end

end