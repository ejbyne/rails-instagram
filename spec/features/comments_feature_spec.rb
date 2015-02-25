require 'rails_helper'

feature 'adding comments' do
 
  let!(:beach) { Picture.create(name: 'Beach') }

  context 'leaving comments' do

    scenario 'allows users to leave a comment using a form' do
      visit '/pictures'
      click_link 'Beach'
      fill_in 'Thoughts', with: 'Awesome'
      click_button 'Comment'
      expect(current_path).to eq "/pictures/#{beach.id}"
      expect(page).to have_content('Awesome')
    end

    scenario 'will not let users leave a comment that is too short' do
      visit '/pictures'
      click_link 'Beach'
      fill_in 'Thoughts', with: 'Aw'
      click_button 'Comment'
      expect(page).not_to have_content('Aw')
      expect(page).to have_content('error')
    end

    scenario 'will not let users leave a comment that is too long' do
      visit '/pictures'
      click_link 'Beach'
      fill_in 'Thoughts', with: '*' * 151
      click_button 'Comment'
      expect(page).not_to have_content('*')
      expect(page).to have_content('error')
    end

  end

end