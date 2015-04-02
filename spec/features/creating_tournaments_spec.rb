feature 'Creating tournaments' do
  use_vcr_cassette 'wednesday', allow_playback_repeats: true

  scenario 'See what the current tournament is' do
    visit '/tourney'
    expect(page).to have_content 'Shell Houston Open'
  end

  scenario 'Create a new tournament from the current one' do
    visit '/tourney'

    click_link 'Create Tournament'

    expect(page).to have_content '144 players added'

    within ('.last') do
      expect(page).to have_content 'Shell Houston Open'
    end

  end



end
