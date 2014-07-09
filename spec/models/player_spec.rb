require 'spec_helper'

describe Player do

  describe 'calculate_today_score' do
    context 'prior to the cut' do
      it 'only uses 4 scores' do
        players = players_with_scores(-1, -1, -1, -1, +3)

        expect(Player.calculate_today_score(players)).to eq -4
      end
    end
    context 'with a player who missed the cut but had the 4th lowest score in the second round' do
      it 'include his score' do
        pending 'better data'
        players = players_with_scores(-1, -1, -1, +1)
        players << Hashie::Mash.new({today:'-', second_round: '69'})

        expect(Player.calculate_today_score(players)).to eq -4

      end
    end

    context 'in third round' do
      it 'only uses 2 scores' do
        players = players_with_scores(-1, -1, +1, +1, +3)

        Timecop.travel(saturday) do
          expect(Player.calculate_today_score(players)).to eq -2
        end
      end
    end
  end

  describe 'calculate_total_score' do
    context 'On day 1' do
      it 'only uses 4 today scores' do
        players = players_with_scores(-1, -1, -1, -1, +3)

        Timecop.travel(thursday) do
          expect(Player.calculate_total_score(players)).to eq -4
        end
      end
    end

    context 'On day 3' do
      it 'only counts 2 scores for saturday' do
        players = []
        players << Hashie::Mash.new({first_round: '70', second_round: '70', today: '-1'})
        players << Hashie::Mash.new({first_round: '70', second_round: '70', today: '-1'})
        players << Hashie::Mash.new({first_round: '70', second_round: '70', today: '+1'})
        players << Hashie::Mash.new({first_round: '70', second_round: '70', today: '+1'})
        players << Hashie::Mash.new({first_round: '70', second_round: '70', today: 'E'})

        Timecop.travel(saturday) do
          expect(Player.calculate_total_score(players)).to eq -2
        end
      end

      context 'with a player who missed the cut' do
        it 'calculates correctly' do
          players = []
          players << Hashie::Mash.new({first_round: '70', second_round: '70', today: '-1'})
          players << Hashie::Mash.new({first_round: '70', second_round: '70', today: '-1'})
          players << Hashie::Mash.new({first_round: '70', second_round: '70', today: '+1'})
          players << Hashie::Mash.new({first_round: '70', second_round: '70', today: '+1'})
          players << Hashie::Mash.new({first_round: '70', second_round: '70', today: '-'})

          Timecop.travel(saturday) do
            expect(Player.calculate_total_score(players)).to eq -2
          end
        end
      end
    end
  end


  def players_with_scores(*scores)
    ret = []
    scores.each do |s|
      ret << PlayerResults.new(Hashie::Mash.new({today: s.to_s}))
    end
    ret
  end



end