require 'rails_helper'

feature 'adding comments' do
 
  let!(:user) { User.create(username: "test", email: "test@test.com", password: "testtest") }
  let!(:henry) { Picture.create(image_file_name: "mock_image", user_id: user.id) }

  context 'leaving comments' do

    scenario 'allows users to leave a comment using a form' do
      sign_up
      leave_comment
      expect(current_path).to eq("/pictures/#{henry.id}")
      expect(page).to have_content('ed: Nice picture')
    end

    scenario 'does not allow users to leave a comment if they are not logged in' do
      leave_comment
      expect(page).to have_content('You must be logged in to leave a comment')
      expect(page).not_to have_content('Nice picture')
    end

    scenario 'will not let users leave a comment that is too short' do
      sign_up
      visit('/pictures')
      find('.picture-link').click
      fill_in('Comment', with: '**')
      click_button('Comment')
      expect(page).not_to have_selector('#comments', text: '**')
      expect(page).to have_content('error')
    end

    scenario 'will not let users leave a comment that is too long' do
      sign_up
      visit('/pictures')
      find('.picture-link').click
      fill_in('Comment', with: '*' * 151)
      click_button('Comment')
      expect(page).not_to have_selector('#comments', text: '**')
      expect(page).to have_content('error')
    end

    scenario 'will let a user delete a comment he or she has created' do
      sign_up
      leave_comment
      expect(page).to have_content('Nice picture')
      click_link('Delete comment')
      expect(page).not_to have_content('Nice picture')
    end

    scenario 'will not let a user delete a comment he or she has not created' do
      comment = Comment.create(comment: 'Nice picture', picture_id: henry.id, user_id: user.id)
      sign_up
      visit('/pictures')
      find('.picture-link').click
      expect(page).to have_content('Nice picture')
      expect(page).not_to have_content('Delete comment')
      page.driver.delete("/pictures/#{henry.id}/comments/#{comment.id}")
      visit "/pictures/#{henry.id}"
      expect(page).to have_content('Nice picture')
    end

    scenario 'will enable a comment to be added when a picture is posted' do
      sign_up
      visit('/pictures/new')
      attach_file('picture[image]', 'spec/features/test_images/henry.jpg')
      fill_in('Comment', with: 'Nice picture')
      click_button('Upload Picture')
      expect(page).to have_css("img[src*='henry.jpg']")
      expect(page).to have_content('Nice picture')
    end

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

  def leave_comment
    visit('/pictures')
    find('.picture-link').click
    fill_in('Comment', with: 'Nice picture')
    click_button('Comment')
  end

end
