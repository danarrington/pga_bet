require 'spec_helper'
# leaberboard.first
# <Hashie::Mash first_round="63" fourth_round="48" name="Ben Crane" position="1" second_round="65" strokes="-11" third_round="69" thru="12" today="+2" total="-11">
describe PlayerResults do

  context 'during initialization'
  it 'should set the today property' do
    f = File.open(Rails.root.join 'spec/data/4th_round_midday.txt')
    leaderboard = Marshal.load(f)
    f.close

    results = PlayerResults.new(leaderboard.first)
    expect(results.today).to eq 2
  end
end