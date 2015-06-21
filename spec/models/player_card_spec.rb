require 'spec_helper'

describe PlayerCard do

  describe '#initialize' do
    context 'for a player with a today value of -' do
      let(:player_data) {player_with_round_scores('70', '2:10 pm', '-', '-')}
      let!(:something) {ScoreKeeper.new}
      subject(:player_card) {PlayerCard.new(player_data)}
      it 'should set started to false' do
        expect(player_card.started).to eq false
      end
    end
  end
end

#TODO: Refactor this to a helper
  def player_with_round_scores(first, second, third, today, fourth = '-')
    name = Faker::Name::first_name
    PlayerResults.new(Hashie::Mash.new({first_round: first.to_s, 
      second_round: second.to_s, third_round: third.to_s, today: today, 
      fourth_round: fourth, name: name}), 70)
  end
