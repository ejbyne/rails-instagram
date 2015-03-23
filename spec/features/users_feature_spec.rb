require 'rails_helper'

feature 'users' do

  context 'user not signed in and on the homepage' do

    scenario 'shows a sign in link and a sign up link' do
      visit('/')
      expect(page).to have_link('Sign up')
      expect(page).to have_link('Sign up')
    end

    scenario 'does not show a sign out link' do
      visit('/')
      expect(page).not_to have_link('Sign out')
    end

  end

  context 'user signs up' do

    before do
      sign_up
    end

    scenario 'shows a welcome message and a sign out link' do
      expect(page).to have_content('Welcome! You have signed up successfully')
      expect(page).to have_link('Sign out')
    end

    scenario 'does not show a sign in link and a sign up link' do
      visit('/')
      expect(page).not_to have_link('Sign in')
      expect(page).not_to have_link('Sign up')
    end

    scenario 'allows the user to sign out' do
      click_link('Sign out')
      expect(page).to have_content('Signed out successfully')
      expect(page).not_to have_link('Sign out')
    end

  end

  context 'user signs in' do

    before do
      sign_up
      click_link('Sign out')
    end

    scenario 'allows the user to sign in' do
      visit('/')
      click_link('Sign in')
      fill_in('Email', with: 'ed@test.com')
      fill_in('Password', with: 'testtest')
      expect(page).to have_content('Sign in successfully.')
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

end
