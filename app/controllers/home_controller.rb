class HomeController < ApplicationController

  def index

    leaderboard = Golfscrape::Client.new.leaderboard

    if current_user
      my_players = current_user.players.collect(&:name)
      @my_scores = leaderboard.select{|x| my_players.include?(x.name)}
      @my_today =  Player.calculate_today_score(@my_scores)
      @my_total =  Player.calculate_total_score(@my_scores)
    end

    other_players = User.all.select{|u| u.picks.count > 0 && u.id != (current_user ? current_user.id : 0)}

    @other_teams = []
    other_players.each do |p|
      players = p.players.collect(&:name)
      scores = leaderboard.select{|x| players.include?(x.name)}
      today =  Player.calculate_today_score(scores)
      total =  Player.calculate_total_score(scores)
      @other_teams << {user: p.name, scores: scores, today: today, total: total}
    end


  end


end

