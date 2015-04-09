feature 'Creating tournaments' do
  use_vcr_cassette 'sunday_pm', allow_playback_repeats: true

  context 'On Sunday with 5 players' do
    let!(:user) {create(:user)}
    let!(:ben) {create(:player, name: 'Ben Crane')}
    let!(:jordan) {create(:player, name: 'Jordan Spieth')}
    let!(:charley) {create(:player, name: 'Charley Hoffman')}
    let!(:austin) {create(:player, name: 'Austin Cook')}
    let!(:blake) {create(:player, name: 'Blake Adams')}
    let!(:tourney) {create(:tournament, course_par: 72)}
    scenario 'Display total score correctly' do
      Pick.create(user:user, player:ben, tournament: tourney)
      Pick.create(user:user, player:jordan, tournament: tourney)
      Pick.create(user:user, player:charley, tournament: tourney)
      Pick.create(user:user, player:austin, tournament: tourney)
      Pick.create(user:user, player:blake, tournament: tourney)
      visit '/'
      expect(page).to have_content '-7'

      find('.use-score', text: '65')
      find('.drop-score', text: '72')
      find('.use-score', text: '69')
      find('.drop-score', text: '70')
      find('.drop-score', text: '-2')
      find('.use-score', text: '-3')
    end

  end

end