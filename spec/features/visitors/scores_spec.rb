feature 'Scores' do
  scenario 'Visitor doesnt get exception' do
    u = FactoryGirl.create(:user)
    u.picks << Pick.new
    visit '/'
  end
end