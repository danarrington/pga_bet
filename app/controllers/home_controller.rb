class HomeController < ApplicationController

  def index

    leaderboard = Golfscrape::Client.new.leaderboard

    if current_user
      my_players = current_user.players.collect(&:name)
      @my_scores = leaderboard.select{|x| my_players.include?(x.name)}
      @my_today =  calculate_today_score(@my_scores)
      @my_total =  calculate_total_score(@my_scores)
    end

    other_players = User.all.select{|u| u.picks.count > 0 && u.id != (current_user ? current_user.id : 0)}

    @other_teams = []
    other_players.each do |p|
      players = p.players.collect(&:name)
      scores = leaderboard.select{|x| players.include?(x.name)}
      today =  calculate_today_score(scores)
      total =  calculate_total_score(scores)
      @other_teams << {user: p.name, scores: scores, today: today, total: total}
    end


  end

  def calculate_total_score(scores)
    
    scores.select{|x| x.total != '-'}.sort_by{|x| x.total.to_i}.take(4).inject(0){|sum, x| sum+x.total.to_i}
  end

  def calculate_today_score(scores)
    scores.select{|x| x.today != '-'}.sort_by{|x| x.today.to_i}.take(4).inject(0){|sum, x| sum+x.today.to_i}
  end


end

