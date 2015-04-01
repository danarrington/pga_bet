require 'spec_helper'

describe Player do

  describe 'calculate_today_score' do
    context 'prior to the cut' do
      it 'only uses 4 scores' do
        players = players_with_scores(-1, -1, -1, -1, +3)
        Timecop.travel(friday) do
          expect(Player.calculate_today_score(players)).to eq -4
        end
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

    context 'with a player who has not started' do
      it 'should only count players who have started' do
        players = players_with_scores(-1, 2)
        players << Hashie::Mash.new({today:'-', third_round: '11:29 am'})

        Timecop.travel(saturday) do
          expect(Player.calculate_today_score(players)).to eq 1
        end
      end
    end

  end

  describe 'calculate_total_score' do
    let(:tournament) { create(:tournament)}
    context 'On day 1' do
      it 'only uses 4 today scores' do
        players = players_with_scores(-1, -1, -1, -1, +3)

        Timecop.travel(thursday) do
          expect(Player.calculate_total_score(players, tournament)).to eq -4
        end
      end
    end

    context 'On day 3' do
      it 'only counts 2 scores for saturday' do
        players = []
        players << player_with_round_scores(70, 70, nil, -1)
        players << player_with_round_scores(70, 70, nil, -1)
        players << player_with_round_scores(70, 70, nil, +1)
        players << player_with_round_scores(70, 70, nil, 'E')

        Timecop.travel(saturday) do
          expect(Player.calculate_total_score(players, tournament)).to eq -2
        end
      end

      context 'with a player who missed the cut' do
        it 'calculates correctly' do
          pending 'Not sure if this case is right'
          Timecop.travel(saturday) do
            players = []
            players << player_with_round_scores(70, 70, nil, -1)
            players << player_with_round_scores(70, 70, nil, -1)
            players << player_with_round_scores(70, 70, nil, +1)
            players << player_with_round_scores(70, 70, nil, +1)
            players << player_with_round_scores(70, 70, nil, '-')

            expect(Player.calculate_total_score(players, tournament)).to eq -2
          end
        end
      end

      context 'with a player who withdraws' do
        it 'does not count the WD score' do
          players = []
          players << player_with_round_scores(70, 70, nil, -1)
          players << player_with_round_scores(70, 70, nil, -1)
          players << player_with_round_scores(70, 70, nil, +1)
          players << player_with_round_scores(70, 70, nil, +1)
          players << player_with_round_scores('WD', 'WD', nil, 'WD')

          Timecop.travel(saturday) do
            expect(Player.calculate_total_score(players, tournament)).to eq -2
          end
        end
      end
    end

    context 'on day four' do
      context 'with a player who withdraws' do
        it 'does not count the WD score' do
          players = []
          players << player_with_round_scores(70, 70, 70, -1, 70)
          players << player_with_round_scores(70, 70, 70, -1, 70)
          players << player_with_round_scores(70, 70, 70, +1, 70)
          players << player_with_round_scores(70, 70, 70, +1, 70)
          players << player_with_round_scores('WD', 'WD', 'WD', 'WD', 'WD')

          Timecop.travel(sunday) do
            expect(Player.calculate_total_score(players, tournament)).to eq -2
          end
        end
      end
    end
  end


  def players_with_scores(*scores)
    ret = []
    scores.each do |s|
      ret << PlayerResults.new(Hashie::Mash.new({today: s.to_s}), 70)
    end
    ret
  end

  def player_with_round_scores(first, second, third, today, fourth = '-')
    PlayerResults.new(Hashie::Mash.new({first_round: first.to_s, second_round: second.to_s, third_round: third.to_s, today: today, fourth_round: fourth}), tournament.course_par)
  end

end
