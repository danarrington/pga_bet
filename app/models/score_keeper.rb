class ScoreKeeper

  def self.calculate_scores(player_results, tournament)
    card = self.build_card(player_results)

    self.decide_used_rounds(card)

    card.calculate_today_score

    card 
  end

  private

  def self.build_card(player_results)
    card = ScoreCard.new
    player_results.each do |player_result|
      card.add_player(player_result)
    end
    card
  end

  ROUNDS = [[4, 2], [3, 2], [2, 4], [1, 4]]

  def self.decide_used_rounds(card)
    ROUNDS.each do |round, to_keep|
      sorted_scores = []
      card.players.each do |player_card|
        round_score = player_card.rounds[round-1] #rounds are not 0 indexed
        if round_score.usable
          sorted_scores << round_score
        end
      end
      sorted_scores.sort.take(to_keep).each{|score| score.used = true}
    end
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
    @today = 0 
    scores.sort.take(scores_to_keep).each do |score|
      @today += score.score
      score.used = true
    end
  end

  def scores_to_keep
    [6, 0].include?(Time.zone.now.wday)  ? 2 :4
  end

end





