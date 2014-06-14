class Player < ActiveRecord::Base

  def self.calculate_today_score(players)
    scores = []
    players.each do |player|
      if player.today == '-'
        scores << get_today_score_from_round(player) - 70
      else
        scores << player.today.to_i
      end

    end
    scores.sort.take(4).inject(0){|sum, x| sum+x}
  end

  def self.get_today_score_from_round(player)
    case Time.now.wday
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
end