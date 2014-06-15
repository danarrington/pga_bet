class Player < ActiveRecord::Base

  def self.calculate_today_score(players)
    scores = []
    players.each do |player|
      if player.today == '-'
        score = get_today_score_from_round(player)
        scores << score - 70 unless !score
      else
        scores << player.today.to_i
      end

    end
    scores.sort.take(scores_to_keep).inject(0){|sum, x| sum+x}
  end

  def self.get_today_score_from_round(player)
    case Time.zone.now.wday
      when 4
        player.first_round.to_i
      when 5
        player.second_round.to_i
      when 6
        player.third_round.to_i
      when 7
        player.fourth_round.to_i
    end
  end

  def self.scores_to_keep
    Time.zone.now.wday < 6 ? 4 :2
  end

  def self.calculate_total_score(players)
    total = 0
    scores = get_round_scores(players)
    scores.each do |score|
      total += score.sort.take(4).inject(:+) if score.any?
    end
    total += Player.calculate_today_score(players)
    total
  end

  def self.get_round_scores(players)
    scores = [[],[],[]]
    day = Time.zone.now.wday
    par = 70
    players.each do |player|
      scores[0] << player.first_round.to_i - 70 if day > 4
      scores[1] << player.second_round.to_i - 70 if day > 5
      scores[2] << player.third_round.to_i - 70 if day > 6 && player.third_round != '-'
    end
    scores
  end
end