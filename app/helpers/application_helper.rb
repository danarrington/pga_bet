module ApplicationHelper

  def score_or_time(score)
    if score.today == '-'
      case Time.now.wday
        when 4
          edt_to_local score.first_round
        when 5
          edt_to_local score.second_round
        when 6
          edt_to_local score.third_round
        when 7
          edt_to_local score.fourth_round
        end
    else
      score.today
    end
  end

  def edt_to_local t
    ActiveSupport::TimeZone.new('America/New_York').parse(t).getlocal.strftime('%l:%M %P')
  end
end
