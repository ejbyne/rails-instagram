require 'rails_helper'

feature 'visiting the homepage' do

  scenario 'shows a welcome message' do
    visit '/'
    expect(page).to have_content('Welcome to Henrygram')
    expect(page).to have_link('Add a picture')
    expect(page).to have_link('View pictures')
  end

end