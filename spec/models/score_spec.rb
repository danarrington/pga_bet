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

end
