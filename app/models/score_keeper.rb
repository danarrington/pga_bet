class ScoreKeeper
  ROUNDS = [[4, 2], [3, 2], [2, 4], [1, 4]]

  def self.calculate_scores(player_results, tournament)
    card = ScoreCard.new
    player_results.each do |player_result|
      card.add_player(player_result)
    end

    ROUNDS.each do |round, to_keep|
      sorted_scores = []
      card.players.each do |player_card|
        sorted_scores << player_card.rounds[round-1] #rounds are not 0 indexed
      end
      sorted_scores.sort.take(to_keep).each{|score| score.used = true}
    end

    card.calculate_today_score

    card 
  end

end

# iterate through each day backwards
# if nothing set round to -
# once we find one

class ScoreCard
  attr_accessor :today, :players

  def initialize
    @players = []
  end

  def add_player(player_results)
    player_card = PlayerCard.new(player_results)
    players << player_card
  end

  def calculate_today_score
    scores = []
    players.each do |player|
        scores << player.today if player.started
    end
    @today = scores.sort.take(scores_to_keep).inject(0){|sum, x| sum+x}
  end

  def scores_to_keep
    [6, 0].include?(Time.zone.now.wday)  ? 2 :4
  end

end

class PlayerCard
  attr_accessor :name, :total, :today, :thru, :today_used, :rounds, :started

  def initialize(player_results)
    @name = player_results.name
    @today = player_results.today
    @started = player_results.started
    @thru = player_results.thru
    @rounds = []
    @rounds[0] = Score.new(player_results.first_round)
    @rounds[1] = Score.new(player_results.second_round)
    @rounds[2] = Score.new(player_results.third_round)
    @rounds[3] = Score.new(player_results.fourth_round)
    
  end

end

class Score < Struct.new(:score, :used)
  def <=>(other)
    self[:score].to_i <=> other[:score].to_i
  end
end



