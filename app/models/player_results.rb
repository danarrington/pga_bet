class PlayerResults
  attr_accessor :today

  def initialize(score_data)
    @today = score_data.today.to_i
  end
end