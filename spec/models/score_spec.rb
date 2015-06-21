require 'spec_helper'

describe Score do

  describe '#usable' do
    
    it 'should count a number as usable' do
      expect(Score.new('-7').usable).to eq true
    end

    it 'should count E as usable' do
      expect(Score.new('E').usable).to eq true
    end

    it 'should count MC as unusable' do
      expect(Score.new('MC').usable).to eq false
    end
  end


  describe '#score_or_time' do
    
    it 'should return a score if player has started' do
      expect(Score.new(-1).score_or_time).to eq -1
    end

    it 'should return MC for missed cut' do
      expect(Score.new('MC').score_or_time).to eq 'MC' 
    end

    it 'should return converted tee time for unstarted player' do
      expect(Score.new('1:35 pm').score_or_time).to eq '10:35 am' 
    end

  end

end
