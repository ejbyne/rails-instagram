module TestHelpers

  def sign_up
    visit('/')
    click_link('Sign up')
    fill_in('Username', with: 'ed')
    fill_in('Email', with: 'ed@test.com')
    fill_in('Password', with: 'testtest')
    fill_in('Password confirmation', with: 'testtest')
    click_button('Sign up')
  end

  def create_image
    user = User.create(username: 'test', email: 'test@test.com', password: 'testtest')
    Picture.create(image_file_name: 'mock_image', user_id: user.id)
  end

  def upload_image
    visit('/pictures/new')
    attach_file('picture[image]', 'spec/features/test_images/henry.jpg')
    click_button('Upload Picture')
  end

  def leave_comment
    visit('/pictures')
    find('.picture-link').click
    fill_in('Comment', with: 'Nice picture')
    click_button('Comment')
  end

end
