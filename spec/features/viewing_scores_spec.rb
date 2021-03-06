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
      pending 'css is not working'
      Pick.create(user:user, player:ben, tournament: tourney)
      Pick.create(user:user, player:jordan, tournament: tourney)
      Pick.create(user:user, player:charley, tournament: tourney)
      Pick.create(user:user, player:austin, tournament: tourney)
      Pick.create(user:user, player:blake, tournament: tourney)
      visit '/'
      expect(page).to have_content '-7'

      find('.is-used', text: '65')
      find('.is-dropped', text: '72')
      find('.is-used', text: '69')
      find('.is-dropped', text: '70')
      find('.is-dropped', text: '-2')
      find('.is-used', text: '-3')
    end
    
    context 'With a former player not participating' do
      let!(:non_user) {create(:user)}
      let!(:new_tourney) {create(:tournament, course_par:70)}

      scenario 'Hide users not participating in this event' do
        Pick.create(user:user, player:ben, tournament: new_tourney)
        Pick.create(user:non_user, player:jordan, tournament: tourney)

        visit '/'
        expect(page).to have_selector('.player-table', count: 1)

      end
    end

  end

end
