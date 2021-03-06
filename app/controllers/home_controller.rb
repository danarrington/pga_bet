class HomeController < ApplicationController

  def index

    leaderboard = Leaderboard.new
    tournament = Tournament.active

    if current_user
      @my_scores = leaderboard.results_for_user(current_user)
      @my_today =  Player.calculate_today_score(@my_scores)
      @my_total =  Player.calculate_total_score(@my_scores, tournament)
      @my_other_scores = ScoreKeeper.calculate_scores(@my_scores, tournament)
      @my_team = {user: 'My Team', scores: @my_other_scores, today: @my_today, total: @my_total}
    end

    other_players = User.all.select{|u| u.picks.count > 0 && u.id != (current_user ? current_user.id : 0)}

    @other_teams = []
    other_players.each do |p|
      scores = leaderboard.results_for_user(p)
      today =  Player.calculate_today_score(scores)
      total =  Player.calculate_total_score(scores, tournament)
      calced_scores = ScoreKeeper.calculate_scores(scores, tournament)
      if calced_scores.players.any?
        @other_teams << {user: p.name, scores: calced_scores, today: today, total: total}
      end
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

# Get leaderboard
# massage leaderboard
# calculate scores, return a score object 
# Scores
#  :today
#  :total
#  Players
#   :name
#   :total
#   :thru
#   :today
#   :today_used
#   Round_1
#     :score
#     :used
# OR 
