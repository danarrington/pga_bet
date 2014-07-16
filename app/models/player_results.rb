class PlayerResults
  attr_accessor :today, :name

  def initialize(score_data)
    @today = score_data.today.to_i
    @name = score_data.name
  end
end