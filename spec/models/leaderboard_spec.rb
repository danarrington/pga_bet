require 'spec_helper'

describe Leaderboard do

  context 'with multiple tournaments' do
    let(:old_tourney) {create(:tournament, start: 1.month.ago)}
    let(:active_tourney) {create(:tournament, start: 1.day.ago)}
    let(:old_player) {create(:player)}
    let(:new_player) {create(:player)}
    subject(:leaderboard) {Leaderboard.new}

    it 'should only return results for active tournament' do
      user = create(:user)
      old_pick = Pick.create(user: user, player: old_player, tournament: old_tourney)
      new_pick = Pick.create(user: user, player: new_player, tournament: active_tourney)
      fake_results = []
      fake_results << create(:player_hash, name: old_player.name)
      fake_results << create(:player_hash, name: new_player.name)
      lb = Golfscrape::Leaderboard.new
      lb.results= fake_results
      subject.instance_variable_set(:@leaderboard, lb)


      expect(leaderboard.results_for_user(user).count).to eq 1

    end
  end

end
