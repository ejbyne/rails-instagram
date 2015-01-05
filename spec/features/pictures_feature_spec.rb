require 'rails_helper'

feature 'pictures' do

  context 'no pictures have been added' do

    scenario 'should display a prompt to add a picture' do
      visit '/pictures'
      expect(page).to have_content 'No pictures yet'
      expect(page).to have_link 'Add a picture'
    end

  end

  context 'pictures have been added' do

    before do
      Picture.create(name: 'Beach')
    end

    scenario 'display pictures' do
      visit '/pictures'
      expect(page).to have_content('Beach')
      expect(page).not_to have_content('No pictures')
    end

  end

  context 'uploading pictures' do

    scenario 'prompts user to fill out a form, then displays the new picture' do
      visit '/pictures'
      click_link 'Add a picture'
      fill_in 'Name', with: 'Beach'
      click_button 'Upload Picture'
      expect(page).to have_content 'Beach'
      expect(current_path).to eq '/pictures'
    end

  end

  context 'viewing pictures' do

    let!(:beach) { Picture.create(name: 'Beach') }

    scenario 'lets a user view a picture' do
      visit '/pictures'
      click_link 'Beach'
      expect(page).to have_content 'Beach'
      expect(current_path).to eq "/pictures/#{beach.id}"
    end

  end

end