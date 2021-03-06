class UsersController < ApplicationController
  before_filter :authenticate_user!

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
  end

  def add_pick
    if Pick.any?
      @selected_user_id = Pick.last.user.id if Pick.last.created_at > 1.minute.ago
    end
    @users = User.where('name is not null').collect{|x| [x.name, x.id]}
    @players = Player.where(active:true).order(:name).collect{|x| [x.name, x.id]}
    @all_users = User.where('name is not null')
  end

  def submit_pick
    user = User.find(params[:user_id])
    player = Player.find(params[:player_id])
    tournament = Tournament.active
    Pick.create(user: user, player: player, tournament: tournament)
    redirect_to :add_pick
  end

end
