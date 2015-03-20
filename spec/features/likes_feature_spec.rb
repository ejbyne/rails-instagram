require 'rails_helper'

feature 'liking pictures' do

  scenario 'a user can like a picture, which updates the like count', js: true do
    visit '/'
    click_link('Sign up')
    fill_in('Email', with: 'test@example.com')
    fill_in('Password', with: 'testtest')
    fill_in('Password confirmation', with: 'testtest')
    click_button('Sign up')
    click_link('Add a picture')
    fill_in 'Name', with: "Del"
    attach_file('picture[image]', 'spec/features/del.jpg')
    click_button 'Upload Picture'
    click_link 'Like'
    expect(page).to have_content('1 Like')
  end

end
