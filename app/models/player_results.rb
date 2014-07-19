class PlayerResults
  attr_accessor :today, :name, :thru, :total, :first_round, :second_round, :third_round, :fourth_round, :started, :tee_time

  def initialize(score_data, course_par)
    @name = score_data.name
    @thru = score_data.thru
    @total = score_data.total.to_i
    @first_round = score_data.first_round
    @second_round = score_data.second_round
    @third_round = score_data.third_round
    @fourth_round = score_data.fourth_round
    @today = get_today_score(score_data, course_par)
  end

  def get_today_score score_data, course_par
    if score_data.today != '-'
      @started = true
      score_data.today.to_i
    else
      round_score = get_round_score_for_today
      if round_score.include?(':')
        @started = false
        @tee_time = round_score
      else
        @started = true
        round_score.to_i-course_par
      end
    end
  end

  def get_round_score_for_today
    case Time.zone.now.wday
      when 4
        @first_round
      when 5
        @second_round
      when 6
        @third_round
      when 7
        @fourth_round
    end
  end
end