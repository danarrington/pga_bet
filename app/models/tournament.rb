class Tournament < ActiveRecord::Base

  def self.active
    Tournament.order(start: :desc).first
  end
end
