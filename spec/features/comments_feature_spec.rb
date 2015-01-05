require 'rails_helper'

feature 'adding comments' do
 
  let!(:beach) { Picture.create(name: 'Beach') }

  scenario 'allows users to leave a comment using a form' do
    visit '/pictures'
    click_link 'Beach'
    fill_in 'Thoughts', with: 'Awesome'
    click_button 'Comment'
    expect(current_path).to eq "/pictures/#{beach.id}"
    expect(page).to have_content('Awesome')
  end

end