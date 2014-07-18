class PlayerResults
  attr_accessor :today, :name, :thru, :total, :first_round, :second_round, :third_round, :fourth_round

  def initialize(score_data)
    @today = score_data.today.to_i
    @name = score_data.name
    @thru = score_data.thru
    @total = score_data.total.to_i
    @first_round = score_data.first_round.to_i
    @second_round = score_data.second_round.to_i
    @third_round = score_data.third_round.to_i
    @fourth_round = score_data.fourth_round.to_i
  end
end