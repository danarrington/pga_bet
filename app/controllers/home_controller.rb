class HomeController < ApplicationController

  def index


    leaderboard = Golfscrape::Client.new.leaderboard

    if current_user
      my_players = current_user.players.collect(&:name)
      @my_scores = leaderboard.select{|x| my_players.include?(x.name)}
      @my_today =  @my_scores.inject(0){|sum, x| sum+x.today.to_i}
      @my_total =  @my_scores.inject(0){|sum, x| sum+x.total.to_i}
    end

    other_players = User.all.select{|u| u.picks.count > 0 && u.id != current_user.id}

    @other_teams = []
    other_players.each do |p|
      players = p.players.collect(&:name)
      scores = leaderboard.select{|x| players.include?(x.name)}
      today =  scores.inject(0){|sum, x| sum+x.today.to_i}
      total =  scores.inject(0){|sum, x| sum+x.total.to_i}
      @other_teams << {user: p.name, scores: scores, today: today, total: total}
    end


  end


end

