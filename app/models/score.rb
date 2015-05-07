class Score < Struct.new(:score, :used)
  def <=>(other)
    self[:score].to_i <=> other[:score].to_i
  end

  def usable
    self.score != 'MC'
  end
end
