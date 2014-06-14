require 'spec_helper'

describe Player do

  describe 'calculate_today_score' do
    context 'prior to the cut' do
      it 'calculates correctly' do
        players = []
        players << Hashie::Mash.new({today:'-1'})
        players << Hashie::Mash.new({today:'-1'})
        players << Hashie::Mash.new({today:'-1'})
        players << Hashie::Mash.new({today:'-1'})
        players << Hashie::Mash.new({today:'+3'})

        expect(Player.calculate_today_score(players)).to eq -4
      end
    end
    context 'with a player who missed the cut but had the 4th lowest score in the second round' do
      it 'include his score' do
        players = []
        players << Hashie::Mash.new({today:'-1'})
        players << Hashie::Mash.new({today:'-1'})
        players << Hashie::Mash.new({today:'-1'})
        players << Hashie::Mash.new({today:'+1'})
        players << Hashie::Mash.new({today:'-', second_round: '69'})

        expect(Player.calculate_today_score(players)).to eq -4

      end
    end

    context 'in third round' do
      it 'something' do
        fail
      end
    end
  end

end