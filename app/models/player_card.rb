class PlayerCard
  attr_accessor :name, :total, :today, :thru, :rounds, :started

  def initialize(player_results)
    @name = player_results.name
    @today = Score.new(player_results.today)
    @started = player_results.started
    @thru = player_results.thru
    @rounds = []
    @rounds[0] = Score.new(player_results.first_round)
    @rounds[1] = Score.new(player_results.second_round)
    @rounds[2] = Score.new(player_results.third_round)
    @rounds[3] = Score.new(player_results.fourth_round)
    
  end

end
