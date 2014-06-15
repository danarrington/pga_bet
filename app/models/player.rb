class Player < ActiveRecord::Base

  def self.calculate_today_score(players)
    scores = []
    players.each do |player|
      if player.today == '-'
        score = get_today_score_from_round(player)
        scores << score - 70 unless !score || score < 10
      else
        scores << player.today.to_i
      end

    end
    scores.sort.take(scores_to_keep).inject(0){|sum, x| sum+x}
  end

  def self.get_today_score_from_round(player)
    case Time.zone.now.wday
      when 5
        player.first_round.to_i
      when 6
        player.second_round.to_i
      when 7
        player.third_round.to_i
      when 0
        player.fourth_round.to_i
    end
  end

  def self.scores_to_keep
    [7, 0].include?(Time.zone.now.wday)  ? 2 :4
  end

  def self.calculate_total_score(players)
    total = 0
    scores = get_round_scores(players)
    i = 0
    scores.each do |score|
      scores_to_take = i > 1 ? 2 : 4
      total += score.sort.take(scores_to_take).inject(:+) if score.any?
      i += 1
    end
    total += Player.calculate_today_score(players)
    total
  end

  def self.get_round_scores(players)
    scores = [[],[],[]]
    day = Time.zone.now.wday
    par = 70
    players.each do |player|
      scores[0] << player.first_round.to_i - 70 if day > 4 || day == 0
      scores[1] << player.second_round.to_i - 70 if day > 5 || day == 0
      scores[2] << player.third_round.to_i - 70 if (day > 6 || day == 0) && !['-', 'MC'].include?(player.third_round)
    end
    scores
  end
end