require 'spec_helper'
describe PlayerResults do

  context 'during initialization' do
    context 'loading Ben Crane' do
      # leaberboard.first
      # <Hashie::Mash first_round="63" fourth_round="48" name="Ben Crane" position="1" second_round="65" strokes="-11" third_round="69" thru="12" today="+2" total="-11">
      subject(:result) {PlayerResults.new(@leaderboard.first, 70)}
      before :each do
        f = File.open(Rails.root.join 'spec/data/4th_round_midday.txt')
        @leaderboard = Marshal.load(f)
        f.close
      end
      it 'should set the today property' do
        expect(result.today).to eq 2
      end

      it 'should set the name property' do
        expect(result.name).to eq "Ben Crane"
      end

      it 'should set the thru property' do
        expect(result.thru).to eq '12'
      end

      it 'should set the total property' do
        expect(result.total).to eq -11
      end

      it 'should set the round scores' do
        expect(result.first_round).to eq '63'
        expect(result.second_round).to eq '65'
        expect(result.third_round).to eq '69'
        expect(result.fourth_round).to eq '48'
      end
    end

    context 'when a round is over' do
      let(:hashie) {Hashie::Mash.new({thru:'F'})}
      subject(:result) { PlayerResults.new(hashie, 70)}
      it 'should set thru to F' do
        expect(result.thru).to eq 'F'
      end
    end

    context 'on day two after missing cut' do
      let(:hashie) {Hashie::Mash.new({today:'-', second_round: '73'})}
      subject(:result) { PlayerResults.new(hashie, 72)}
      it 'should set today score based on round' do
        Timecop.travel(friday) do
          expect(result.today).to eq 1
        end
      end

      it 'should set started to true' do
        Timecop.travel(friday) do
          expect(result.started).to be true
        end
      end
    end

    context 'on day two before starting' do
      let(:hashie) {Hashie::Mash.new({today:'-', second_round: '11:34 am'})}
      subject(:result) { PlayerResults.new(hashie, 72)}

      it 'should set started to false' do
        Timecop.travel(friday) do
          expect(result.started).to be false
        end
      end

      it 'should set tee_time to 11:34 am' do
        Timecop.travel(friday) do
          expect(result.tee_time).to eq '11:34 am'
        end
      end
    end

    context 'on day three after missing cut' do
      let(:hashie) {Hashie::Mash.new({today:'-', third_round: 'MC'})}
      subject(:result) { PlayerResults.new(hashie, 72)}
      before :each do
        Timecop.freeze saturday
      end
      after :each do
        Timecop.return
      end
      it 'should set started to false' do
        expect(result.started).to be false
      end
    end

    context 'on day two after withdrawing' do
      let(:hashie) {Hashie::Mash.new({today:'WD', first_round: 'WD', second_round: 'WD', thru: 'WD'})}
      subject(:result) { PlayerResults.new(hashie, 72)}
      it 'should set started to false' do
        Timecop.travel(friday) do
          expect(result.started).to be false
        end
      end
    end

    context 'Withdrawing on second day' do #Paul Casey Players 2015
      let(:hashie) {Hashie::Mash.new({today:'-', first_round: '78', 
        second_round: 'WD', third_round: 'WD', fourth_round: 'WD', 
        thru: '-'})}
      subject(:result) { PlayerResults.new(hashie, 72)}
      it 'should set started to false' do
        expect(result.started).to be false
      end
    end
  end
end
