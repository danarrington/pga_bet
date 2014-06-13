class UsersController < ApplicationController
  before_filter :authenticate_user!

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
  end

  def add_pick
    @users = User.where('name is not null').collect{|x| [x.name, x.id]}
    @players = Player.all.order(:name).collect{|x| [x.name, x.id]}
    @all_users = User.where('name is not null')
  end

  def submit_pick
    User.find(params[:user_id]).players << Player.find(params[:player_id])
    redirect_to :add_pick
  end

end
