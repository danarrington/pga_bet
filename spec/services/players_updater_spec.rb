require 'spec_helper'

describe PlayersUpdater do
  use_vcr_cassette 'wednesday'

  subject(:result) {PlayersUpdater.update_players}

  it 'creates new players' do
    subject
    expect(Player.count).to eq 144
  end

  it 'returns the number of new players' do
    expect(subject[:new]).to eq 144
  end

  it 'sets new players to active' do
    subject
    active_players = Player.where(active:true).count
    expect(active_players).to eq 144
  end

  context 'with existing players' do

    let!(:player) {create(:player, name: 'Ernie Els', active: false)}
    let!(:happy_gilmore) {create(:player, name: 'Happy Gilmore', active: true)}

    it 'returns the number of updated players' do
      expect(subject[:updated]).to eq 1
    end
    it 'sets existing participating players to active' do
      subject
      player.reload
      expect(player.active).to be true
    end

    it 'sets existing non-participating players to unactive' do
      subject
      happy_gilmore.reload
      expect(happy_gilmore.active).to be false
    end

  end

end
