class Score < Struct.new(:score, :used)
  def <=>(other)
    self[:score].to_i <=> other[:score].to_i
  end

  def usable
    self.score != 'MC'
  end

  def score_or_time
    unless self.score.to_s.include? ':'
      return self.score 
    end
    ActiveSupport::TimeZone.new('America/New_York').parse(self.score).in_time_zone('Pacific Time (US & Canada)').strftime('%l:%M %P')
  end
end
