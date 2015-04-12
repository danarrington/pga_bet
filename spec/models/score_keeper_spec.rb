require 'spec_helper'

describe ScoreKeeper do

  describe '#calculate_scores' do
    context 'prior to the cut' do
      let!(:user) {create(:user)}
      let!(:tournament) {create(:tournament, course_par: 70)}
      let(:players){[]}

      before do
        players << player_with_round_scores(70, '24', '-', '-1')
        players << player_with_round_scores(70, '34', '-', 'E')
        players << player_with_round_scores(70, '19', '-', '+1')
        players << player_with_round_scores(70, '38', '-', '-2')
        players << player_with_round_scores(70, '48', '-', 'E')
      end

      it 'calculates the total score using top 4' do
        scores = ScoreKeeper.calculate_scores(players, tournament)
        puts 'BACK'
        pp scores
        expect(scores.today).to eq -3
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

