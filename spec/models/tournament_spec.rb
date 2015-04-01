require 'spec_helper'

describe Tournament do

  context 'with multiple tournaments' do
    it 'should return the latest starting tournament as active' do
      later_tourney = create(:tournament, start: 1.day.ago)
      early_tourney = create(:tournament, start: 1.month.ago)

      expect(Tournament.active).to eq(later_tourney)
    end
  end

  it 'started? returns true if started' do
    tournament = create(:tournament, start: 1.day.ago)
    expect(tournament.started?).to eq true
  end

  it 'started? returns false if not started' do
    tournament = create(:tournament, start: 1.day.from_now)
    expect(tournament.started?).to eq false
  end

end
