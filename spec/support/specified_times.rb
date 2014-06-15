module SpecifiedTimes
  def saturday
    Time.zone = "Pacific Time (US & Canada)"
    saturday = Date.commercial(Date.today.year, Date.today.cweek, 6)
    Time.new(saturday.year, saturday.month, saturday.day, 10, 0, 0).in_time_zone('Pacific Time (US & Canada)')
  end

  def thursday
    Time.zone = "Pacific Time (US & Canada)"
    thursday = Date.commercial(Date.today.year, Date.today.cweek, 4)
    Time.new(thursday.year, thursday.month, thursday.day, 10, 0, 0).in_time_zone('Pacific Time (US & Canada)')
  end
end
