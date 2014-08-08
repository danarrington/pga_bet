class Player < ActiveRecord::Base

  def self.calculate_today_score(players)
    scores = []
    players.each do |player|
        scores << player.today if player.started
    end
    scores.sort.take(scores_to_keep).inject(0){|sum, x| sum+x}
  end


  def self.scores_to_keep
    [6, 0].include?(Time.zone.now.wday)  ? 2 :4
  end

  def self.calculate_total_score(players, tournament)
    total = 0
    scores = get_round_scores(players, tournament)
    i = 0
    scores.each do |score|
      scores_to_take = i > 1 ? 2 : 4
      total += score.sort.take(scores_to_take).inject(:+) if score.any?
      i += 1
    end
    total += Player.calculate_today_score(players)
    total
  end

  def self.get_round_scores(players, tournament)
    scores = [[],[],[]]
    day = Time.zone.now.wday
    par = tournament.course_par
    players.each do |player|
      scores[0] << player.first_round.to_i - par if (day > 4 || day == 0) && player.first_round != 'WD'
      scores[1] << player.second_round.to_i - par if (day > 5 || day == 0) && player.second_round != 'WD'
      scores[2] << player.third_round.to_i - par if (day > 6 || day == 0) && !['-', 'MC'].include?(player.third_round)
    end
    scores
  end
end