feature 'Scores' do
  #TODO: shouldn't need these
  use_vcr_cassette 'monday'
  let!(:tournament) {create(:tournament)}
  scenario 'Visitor doesnt get exception' do
    u = FactoryGirl.create(:user)
    u.picks << Pick.new
    visit '/'
  end
end
