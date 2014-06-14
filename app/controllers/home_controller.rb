class HomeController < ApplicationController

  def index

    leaderboard = Golfscrape::Client.new.leaderboard

    if current_user
      my_players = current_user.players.collect(&:name)
      @my_scores = leaderboard.select{|x| my_players.include?(x.name)}
      @my_today =  Player.calculate_today_score(@my_scores)
      @my_total =  calculate_total_score(@my_scores)
    end

    other_players = User.all.select{|u| u.picks.count > 0 && u.id != (current_user ? current_user.id : 0)}

    @other_teams = []
    other_players.each do |p|
      players = p.players.collect(&:name)
      scores = leaderboard.select{|x| players.include?(x.name)}
      today =  Player.calculate_today_score(scores)
      total =  calculate_total_score(scores)
      @other_teams << {user: p.name, scores: scores, today: today, total: total}
    end


  end

  def calculate_total_score(player_scores)
    total = 0
    scores = get_round_scores(player_scores)
    scores.each do |score|
      total += score.sort.take(4).inject(:+) if score.any?
    end
    total += Player.calculate_today_score(player_scores)
    total
  end

  def get_round_scores(players)
    scores = [[],[],[]]
    day = Time.now.wday
    par = 70
    players.each do |player|
      scores[0] << player.first_round.to_i - 70 if day > 4
      scores[1] << player.second_round.to_i - 70 if day > 5
      scores[2] << player.third_round.to_i - 70 if day > 6 && player.third_round != '-'
    end
    scores
  end

end

