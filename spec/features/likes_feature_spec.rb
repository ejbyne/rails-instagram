require 'rails_helper'
require_relative 'helpers/test_helper'

include TestHelpers

feature 'liking pictures' do

  scenario 'allows a user to like a picture, which updates the like count', js: true do
    sign_up
    upload_image
    click_link('Like')
    expect(page).to have_content('1 Like')
  end

end
