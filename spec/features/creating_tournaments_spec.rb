feature 'Creating tournaments' do

  scenario 'See what the current tournament is' do
    visit '/tourney'
    expect(page).to have_content 'Valero Texas Open'
  end

  scenario 'Create a new tournament from the current one' do
    visit '/tourney'

    click_link 'Create Tournament'

    within ('.last') do
      expect(page).to have_content 'Valero Texas Open'
    end

  end



end
