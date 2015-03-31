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

  private

  def get_today_score score_data, course_par
    case score_data.today
      when '-'
        round_score = get_round_score_for_today
        if round_score.include?(':')
          @started = false
          @tee_time = round_score
        elsif round_score == 'MC'
          @started = false
          'MC'
        else
          @started = true
          round_score.to_i-course_par
        end
      when 'WD'
        @started = false
        'WD'
      else
        @started = true
        score_data.today.to_i
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
      when 0
        @fourth_round
    end
  end
end
