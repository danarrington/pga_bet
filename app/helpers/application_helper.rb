module ApplicationHelper

  def score_or_time(score)
    if score.today == '-'
      case Time.now.wday
        when 4
          score.first_round
        when 5
          score.second_round
        when 6
          score.third_round
        when 7
          score.fourth_round
        end
    else
      score.today
    end
  end
end
