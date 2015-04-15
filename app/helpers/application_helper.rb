module ApplicationHelper

  def edt_to_local t
    begin
    ActiveSupport::TimeZone.new('America/New_York').parse(t).in_time_zone('Pacific Time (US & Canada)').strftime('%l:%M %P')
    rescue
      t
    end

  end

  def used_class(score)
    !!score.used ? 'is-used' : 'is-dropped'
  end
end
