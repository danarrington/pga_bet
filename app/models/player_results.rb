class PlayerResults
  attr_accessor :today, :name, :thru, :total

  def initialize(score_data)
    @today = score_data.today.to_i
    @name = score_data.name
    @thru = score_data.thru.to_i
    @total = score_data.total.to_i
  end
end