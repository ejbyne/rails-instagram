require 'rails_helper'

feature 'liking pictures' do

  let!(:user) { User.create(email: "test@test.com", password: "testtest") }
  let!(:beach) { Picture.create(name: 'Beach', user_id: user.id) }

  scenario 'a user can like a picture, which updates the like count', js: true do
    visit "/pictures/#{beach.id}"
    click_link 'Like'
    expect(page).to have_content('1 Like')
  end

end
