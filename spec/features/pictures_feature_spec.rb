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
      beach = Picture.find_by(name: 'Beach')
      expect(page).to have_content 'Beach'
      expect(current_path).to eq "/pictures/#{beach.id}"
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

  context 'editing pictures' do

    let!(:beach) { Picture.create(name: 'Beach') }

    scenario 'lets a user edit a picture' do
      visit "/pictures/#{beach.id}"
      click_link 'Edit picture'
      fill_in 'Name', with: 'Sunny Beach'
      click_button 'Update Picture'
      expect(page).to have_content 'Sunny Beach'
      expect(current_path).to eq '/pictures'   
    end

  end

  context 'deleting pictures' do

    let!(:beach) { Picture.create(name: 'Beach') }

    scenario 'removes a picture when a user clicks a delete link' do
      visit "/pictures/#{beach.id}"
      click_link 'Delete picture'
      expect(page).not_to have_content 'Beach'
      expect(page).to have_content 'Picture deleted successfully'
    end

  end

  context 'allows an image to be uploaded for a picture' do

    scenario "picture create form contains image upload option" do
      visit '/pictures/new'
      expect(page).to have_selector('#picture_image')
    end

    scenario "allows an image to be uploaded" do
      visit '/pictures/new'
      fill_in 'Name', with: "Del"
      attach_file('picture[image]', 'spec/features/del.jpg')
      click_button 'Upload Picture'
      expect(page).to have_css("img[src*='del.jpg']")
    end

  end

end
