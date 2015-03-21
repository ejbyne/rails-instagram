require 'rails_helper'

feature 'adding comments' do
 
  let!(:user) { User.create(username: "test", email: "test@test.com", password: "testtest") }
  let!(:beach) { Picture.create(image_file_name: "mock_image", user_id: user.id) }

  context 'leaving comments' do

    scenario 'allows users to leave a comment using a form' do
      sign_up
      visit '/pictures'
      find('.picture-link').click
      fill_in 'Comment', with: 'Awesome'
      click_button 'Comment'
      expect(current_path).to eq "/pictures/#{beach.id}"
      expect(page).to have_content('example: Awesome')
    end

    scenario 'does not allow users to leave a comment if they are not logged in' do
      visit '/pictures'
      find('.picture-link').click
      fill_in 'Comment', with: 'Awesome'
      click_button 'Comment'
      expect(page).to have_content('You must be logged in to leave a comment')
      expect(page).not_to have_content('Awesome')
    end

    scenario 'will not let users leave a comment that is too short' do
      sign_up
      visit '/pictures'
      find('.picture-link').click
      fill_in 'Comment', with: 'Aw'
      click_button 'Comment'
      expect('#comment').not_to have_content('Aw')
      expect(page).to have_content('error')
    end

    scenario 'will not let users leave a comment that is too long' do
      sign_up
      visit '/pictures'
      find('.picture-link').click
      fill_in 'Comment', with: '*' * 151
      click_button 'Comment'
      expect('#comments').not_to have_content('*')
      expect(page).to have_content('error')
    end

    scenario 'will let a user delete a comment he or she has created' do
      sign_up
      visit '/pictures'
      find('.picture-link').click
      fill_in 'Comment', with: 'Great'
      click_button 'Comment'
      expect(page).to have_content('Great')
      click_link 'Delete comment'
      expect(page).not_to have_content('Great')
    end

    scenario 'will not let a user delete a comment he or she has not created' do
      Comment.create(comment: 'Awful', picture_id: beach.id, user_id: user.id)
      sign_up
      visit '/pictures'
      find('.picture-link').click
      expect(page).to have_content('Awful')
      expect(page).not_to have_content('Delete comment')
    end

    scenario 'will enable a comment to be added when a picture is posted' do
      sign_up
      visit '/pictures/new'
      attach_file('picture[image]', 'spec/features/del.jpg')
      fill_in 'Comment', with: 'Delboy'
      click_button 'Upload Picture'
      expect(page).to have_css("img[src*='del.jpg']")
      expect(page).to have_content('Delboy')
    end

  end

  def sign_up
    visit('/')
    click_link('Sign up')
    fill_in('Username', with: 'example')
    fill_in('Email', with: 'test@example.com')
    fill_in('Password', with: 'testtest')
    fill_in('Password confirmation', with: 'testtest')
    click_button('Sign up')
  end

end
