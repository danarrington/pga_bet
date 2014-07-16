require 'spec_helper'

describe UsersController do
  include Devise::TestHelpers
  describe 'POST #submit_pick' do

    context 'with an active tournament' do
      let!(:user) {create(:user)}
      before :each do
        sign_in user
        @tournament = create(:tournament)
      end
      it 'should assign the current tournament to the pick' do
        player = create(:player)
        post :submit_pick, user_id: user.id, player_id: player.id
        expect(Pick.first.tournament).to eq(@tournament)
      end
    end
  end
end