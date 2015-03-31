class Leaderboard

  def results_for_user(user)
    tournament = Tournament.active
    player_names = user.picks.where(tournament: tournament).collect{|x| x.player.name}
    leaderboard.results.select{|x| player_names.include?(x.name)}.map{|x| PlayerResults.new(x, tournament.course_par)}

  end


  private
  def leaderboard
    @leaderboard ||= Golfscrape::Client.new.leaderboard
  end

end
