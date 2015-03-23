require 'rails_helper'
require_relative 'helpers/test_helper'

include TestHelpers

feature 'pictures' do

  context 'no pictures have been added' do

    scenario 'displays a prompt to add a picture' do
      sign_up
      find('.view-pictures-button').click
      expect(page).to have_content('No pictures yet')
      expect(page).to have_link('Add a picture')
      find('.add-picture-button').click
      expect(current_path).to eq('/pictures/new')
    end

  end

  context 'pictures have been added' do

    let!(:mock_image) { create_image }

    scenario 'displays pictures' do
      visit('/pictures')
      expect(page).to have_css('.thumbnail')
      expect(page).not_to have_content('No pictures')
    end

    scenario 'allows a user to view a picture' do
      visit('/pictures')
      find('.picture-link').click
      expect(current_path).to eq("/pictures/#{mock_image.id}")
    end

  end

  context 'uploading pictures' do

    scenario 'prompts user to fill out a form, then displays the new picture' do
      sign_up
      upload_image
      henry = Picture.find_by(image_file_name: 'henry.jpg')
      expect(current_path).to eq("/pictures/#{henry.id}")
      expect(page).to have_css("img[src*='henry.jpg']")
      expect(page).to have_content('Picture added by ed (0 hours ago)')
    end

    scenario 'does not allow a picture to be added if the user is not logged in' do
      visit('/pictures/new')
      expect(page).not_to have_content('Upload Picture')
      expect(page).to have_content('You must be logged in to add a picture')
    end

  end

  context 'deleting pictures' do

    scenario 'removes a picture when a user clicks a delete link' do
      sign_up
      upload_image
      click_link('Delete picture')
      expect(page).to have_content('Picture deleted successfully')
      expect(current_path).to eq('/pictures')
    end

    scenario 'does not allow a user to delete a picture he or she has not created' do
      mock_image = create_image
      sign_up
      visit("/pictures/#{mock_image.id}")
      expect(page).not_to have_content("Delete picture")
      page.driver.delete("/pictures/#{mock_image.id}")
      visit("/pictures/#{mock_image.id}")
      expect(page).to have_css('img')
    end

  end

  context 'pagination' do

    scenario 'paginates thumbnails so that there are a maximum of 12 on each page' do
      sign_up
      13.times { upload_image }
      visit('/pictures')
      expect(page).to have_selector('.thumbnail', count: 12)
      click_link('Next')
      expect(page).to have_selector('.thumbnail', count: 1)
    end

  end

end
