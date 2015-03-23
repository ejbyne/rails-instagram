require 'rails_helper'

feature 'liking pictures' do

  scenario 'allows a user to like a picture, which updates the like count', js: true do
    sign_up
    upload_image
    click_link('Like')
    expect(page).to have_content('1 Like')
  end

  def sign_up
    visit('/')
    click_link('Sign up')
    fill_in('Username', with: 'ed')
    fill_in('Email', with: 'ed@test.com')
    fill_in('Password', with: 'testtest')
    fill_in('Password confirmation', with: 'testtest')
    click_button('Sign up')
  end

def upload_image
    visit('/pictures/new')
    attach_file('picture[image]', 'spec/features/test_images/henry.jpg')
    click_button('Upload Picture')
  end

end
