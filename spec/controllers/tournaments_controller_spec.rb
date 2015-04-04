require 'spec_helper'

describe TournamentsController do

  describe 'POST #create' do
    use_vcr_cassette 'wednesday', allow_playback_repeats: true
      
    it 'should create a new tournament' do
      expect {
        post :create 
      }.to change(Tournament, :count).by(1)
    end

    it 'should set the tournament name' do
      post :create

      expect(Tournament.last.name).to eq 'Shell Houston Open'
    end

    it 'should set the start date' do
      post :create
      expect(Tournament.last.start).to eq Date.new(2015, 4, 2)
    end

    it 'should set the course par' do
      post :create
      expect(Tournament.last.course_par).to eq 72
    end

  end

end
