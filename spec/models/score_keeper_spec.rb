require 'spec_helper'

describe ScoreKeeper do

  describe '#calculate_scores' do
    let!(:tournament) {create(:tournament, course_par: 70)}
    let(:players){[]}
    context 'prior to the cut' do

      before do
        players << player_with_round_scores(70, '24', '-', '-1')
        players << player_with_round_scores(70, '34', '-', 'E')
        players << player_with_round_scores(70, '19', '-', '+1')
        players << player_with_round_scores(70, '38', '-', '-2')
        players << player_with_round_scores(70, '48', '-', 'E')
      end

      it 'calculates the today score using top 4' do
        scores = ScoreKeeper.calculate_scores(players, tournament)
        expect(scores.today).to eq -3
      end

      it 'sets today_used for the 4 highest scores' do 
        scores = ScoreKeeper.calculate_scores(players, tournament)
        used_scores = scores.players.select{ |p| p.today.used}
        unused_scores = scores.players.select{ |p| p.today.used != true}

        expect(used_scores.count).to eq 4
        expect(unused_scores.count).to eq 1
        expect(unused_scores.first.today.score).to eq 1 #+1

      end
    end

    context 'after the cut' do
      before do
        players << player_with_round_scores('70', '72', 'MC', '-')
        players << player_with_round_scores('70', '72', '24', 'E')
        players << player_with_round_scores('70', '72', '38', '+1')
      end

      it 'does not use an MC score' do
        scores = ScoreKeeper.calculate_scores(players, tournament)

        scores.players.each do |player|
          player.rounds.each do |round|
            if round.score == 'MC'
              expect(!!round.used).to eq false
            end
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
    name = Faker::Name::first_name
    PlayerResults.new(Hashie::Mash.new({first_round: first.to_s, 
      second_round: second.to_s, third_round: third.to_s, today: today, 
      fourth_round: fourth, name: name}), tournament.course_par)
  end
end

