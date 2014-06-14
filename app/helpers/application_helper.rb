module ApplicationHelper

  def score_or_time(score)
    if score.today == '-'
      case Time.zone.now.wday
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
    begin
    ActiveSupport::TimeZone.new('America/New_York').parse(t).in_time_zone('Pacific Time (US & Canada)').strftime('%l:%M %P')
    rescue
      t
    end

  end
end
