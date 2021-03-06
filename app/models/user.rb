class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :picks
  has_many :players, :through => :picks


  def current_picks
    picks.where(tournament: Tournament.active).all
  end
end
