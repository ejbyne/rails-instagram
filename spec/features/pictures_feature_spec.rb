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
      user = User.create(email: "test@test.com", password: "testtest")
      Picture.create(image_file_name: "mock_image", user_id: user.id)
    end

    scenario 'display pictures' do
      visit '/pictures'
      expect(page).to have_content('Beach')
      expect(page).not_to have_content('No pictures')
    end

  end

  context 'uploading pictures' do

    scenario 'prompts user to fill out a form, then displays the new picture' do
      sign_up
      visit '/pictures'
      click_link 'Add a picture'
      attach_file('picture[image]', 'spec/features/del.jpg')
      click_button 'Upload Picture'
      beach = Picture.find_by(name: 'Beach')
      expect(page).to have_content 'Beach'
      expect(current_path).to eq "/pictures/#{beach.id}"
    end


    scenario 'does not allow a picture to be added if the user is not logged in' do
      visit '/pictures/new'
      expect(page).not_to have_content('Upload Picture')
      expect(page).to have_content('You must be logged in to add a picture')
    end

  end

  context 'viewing pictures' do

    let!(:user) { User.create(email: "test@test.com", password: "testtest") }
    let!(:beach) { Picture.create(image_file_name: "mock_image", user_id: user.id) }

    scenario 'lets a user view a picture' do
      visit '/pictures'
      find('img').click
      expect(current_path).to eq "/pictures/#{beach.id}"
    end

  end

  context 'editing pictures' do

    let!(:user) { User.create(email: "test@test.com", password: "testtest") }
    let!(:beach) { Picture.create(image_file_name: "mock_image", user_id: user.id) }

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

    let!(:user) { User.create(email: "test@test.com", password: "testtest") }
    let!(:beach) { Picture.create(image_file_name: "mock_image", user_id: user.id) }

    scenario 'removes a picture when a user clicks a delete link' do
      visit "/pictures/#{beach.id}"
      click_link 'Delete picture'
      expect(page).not_to have_content 'Beach'
      expect(page).to have_content 'Picture deleted successfully'
    end

  end

  context 'allows an image to be uploaded for a picture' do

    scenario "picture create form contains image upload option" do
      sign_up
      visit '/pictures/new'
      expect(page).to have_selector('#picture_image')
    end

    scenario "allows an image to be uploaded" do
      sign_up
      visit '/pictures/new'
      attach_file('picture[image]', 'spec/features/del.jpg')
      click_button 'Upload Picture'
      expect(page).to have_css("img[src*='del.jpg']")
    end

  end

  def sign_up
    visit('/')
    click_link('Sign up')
    fill_in('Email', with: 'test@example.com')
    fill_in('Password', with: 'testtest')
    fill_in('Password confirmation', with: 'testtest')
    click_button('Sign up')
  end

end
