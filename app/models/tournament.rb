class Tournament < ActiveRecord::Base

  def self.active
    Tournament.order(start: :desc).first
  end

  def started?
    Date.today >= self.start
  end
end
