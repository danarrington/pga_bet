class HomeController < ApplicationController

  def index

    leaderboard = Leaderboard.new

    if current_user
      @my_scores = leaderboard.results_for_user(current_user)
      @my_today =  Player.calculate_today_score(@my_scores)
      @my_total =  Player.calculate_total_score(@my_scores)
    end

    other_players = User.all.select{|u| u.picks.count > 0 && u.id != (current_user ? current_user.id : 0)}

    @other_teams = []
    other_players.each do |p|
      scores = leaderboard.results_for_user(p)
      today =  Player.calculate_today_score(scores)
      total =  Player.calculate_total_score(scores)
      @other_teams << {user: p.name, scores: scores, today: today, total: total}
    end
  end

  def all_results
    leaderboard = Leaderboard.new
    @teams = []
    players = User.all.select{|u| u.picks.count > 0}
    players.each do |p|
      scores = leaderboard.results_for_user(p)
      @teams << scores
    end
  end


end

